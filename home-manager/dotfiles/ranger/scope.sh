#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

## Meanings of exit codes: {{{
## code | meaning    | action of ranger
## -----+------------+-------------------------------------------
## 0    | success    | Display stdout as preview
## 1    | no preview | Display no preview at all
## 2    | plain text | Display the plain content of the file
## 3    | fix width  | Don't reload when width changes
## 4    | fix height | Don't reload when height changes
## 5    | fix both   | Don't ever reload
## 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
## 7    | image      | Display the file directly as an image
# }}}

## Script arguments {{{
FILE_PATH="${1}"
PV_WIDTH="${2}"
## shellcheck disable=SC2034
PV_HEIGHT="${3}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5}"
# }}}

## File extensions {{{
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
# }}}

## Settings {{{
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=${HIGHLIGHT_TABWIDTH:-8}
HIGHLIGHT_STYLE=${HIGHLIGHT_STYLE:-pablo}
HIGHLIGHT_OPTIONS="--replace-tabs=${HIGHLIGHT_TABWIDTH} --style=${HIGHLIGHT_STYLE} ${HIGHLIGHT_OPTIONS:-}"
PYGMENTIZE_STYLE=${PYGMENTIZE_STYLE:-autumn}
OPENSCAD_IMGSIZE=${RNGR_OPENSCAD_IMGSIZE:-1000,1000}
OPENSCAD_COLORSCHEME=${RNGR_OPENSCAD_COLORSCHEME:-Tomorrow Night}
# }}}

handle_extension() { # {{{1
    case "${FILE_EXTENSION_LOWER}" in
        m4a) # {{{2
            mediainfo "${FILE_PATH}" && exit 5
            ;;

        ipynb) # {{{2
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            ;;

        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip) # {{{2
			## Archive
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;

        rar) # {{{2
            ## Avoid password prompt by providing empty password
            unrar lt -p- -- "${FILE_PATH}" && exit 5
            exit 1;;

        7z) # {{{2
            ## Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 5
            exit 1;;

        pdf) # {{{2
			## PDF
            ## Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
              fmt -w "${PV_WIDTH}" && exit 5
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
              fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        torrent) # {{{2
			## BitTorrent
            transmission-show -- "${FILE_PATH}" && exit 5
            exit 1;;

        odt|ods|odp|sxw) # {{{2
			## OpenDocument
            ## Preview as text conversion
            odt2txt "${FILE_PATH}" && exit 5
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            exit 1;;

        xlsx) # {{{2
			## XLSX
            ## Preview as csv conversion
            ## Uses: https://github.com/dilshod/xlsx2csv
            xlsx2csv -- "${FILE_PATH}" && exit 5
            exit 1;;

        htm|html|xhtml) # {{{2
			## HTML
            ## Preview as text conversion
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            w3m -dump "${FILE_PATH}" && exit 5
            lynx -dump -- "${FILE_PATH}" && exit 5
            elinks -dump "${FILE_PATH}" && exit 5
            ;;

        json) # {{{2
			## JSON
            jq --color-output . "${FILE_PATH}" | bat --theme=ansi --color=always --style='numbers,changes,grid,rule,snip' && exit 5
            jq --color-output . "${FILE_PATH}" && exit 5
            python -m json.tool -- "${FILE_PATH}" && exit 5
            ;;

        dff|dsf|wv|wvc) # {{{2
			## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
			## by file(1).
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            ;;
	# }}}2
    esac
} # }}}1

handle_image() { # {{{1
    local DEFAULT_SIZE="1920x1080"
    local mimetype="${1}"

    case "${mimetype}" in
         image/svg+xml|image/svg) # {{{2
			 ## SVG
             convert -- "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
             exit 1;;

         image/vnd.djvu) # {{{2
			 ## DjVu
             ddjvu -format=tiff -quality=90 -page=1 -size="${DEFAULT_SIZE}" \
                   - "${IMAGE_CACHE_PATH}" < "${FILE_PATH}" \
                   && exit 6 || exit 1;;

        image/*) # {{{2
			## Image
            local orientation
            orientation="$( identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}" )"
            if [[ -n "$orientation" && "$orientation" != 1 ]]; then
                convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && exit 6
            fi

            ## `w3mimgdisplay` will be called for all images (unless overriden
            ## as above), but might fail for unsupported types.
            exit 7;;

         video/*) # {{{2
			 ## Video
             # Thumbnail
             ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
             exit 1;;

         application/pdf) # {{{2
			## PDF
             pdftoppm -f 1 -l 1 \
                      -scale-to-x "${DEFAULT_SIZE%x*}" \
                      -scale-to-y -1 \
                      -singlefile \
                      -jpeg -tiffcompression jpeg \
                      -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
                 && exit 6 || exit 1;;


        application/epub+zip|application/x-mobipocket-ebook|\
        application/x-fictionbook+xml) # {{{2
			## ePub, MOBI, FB2 (using Calibre)
            epub-thumbnailer "${FILE_PATH}" "${IMAGE_CACHE_PATH}" \
                "${DEFAULT_SIZE%x*}" && exit 6
            ebook-meta --get-cover="${IMAGE_CACHE_PATH}" -- "${FILE_PATH}" \
                >/dev/null && exit 6
            exit 1;;

        application/font*|application/*opentype) # {{{2
			## Font
            preview_png="/tmp/$(basename "${IMAGE_CACHE_PATH%.*}").png"
            if fontimage -o "${preview_png}" \
                         --pixelsize "120" \
                         --fontname \
                         --pixelsize "80" \
                         --text "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  " \
                         --text "  abcdefghijklmnopqrstuvwxyz  " \
                         --text "  0123456789.:,;(*!?') ff fl fi ffi ffl  " \
                         --text "  The quick brown fox jumps over the lazy dog.  " \
                         "${FILE_PATH}";
            then
                convert -- "${preview_png}" "${IMAGE_CACHE_PATH}" \
                    && rm "${preview_png}" \
                    && exit 6
            else
                exit 1
            fi
            ;;
		# }}}2
    esac
} # }}}1

handle_mime() { # {{{1
    local mimetype="${1}"

    case "${mimetype}" in
        text/rtf|*msword) # {{{2
			## RTF and DOC
            catdoc -- "${FILE_PATH}" && exit 5
            exit 1;;

        *wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml) # {{{2
			## DOCX, ePub, FB2 (using markdown)
            pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
            exit 1;;

        *ms-excel) # {{{2
			## XLS
            xls2csv -- "${FILE_PATH}" && exit 5
            exit 1;;

        text/* | */xml) # {{{2
			## Text
            bat --theme=ansi --color=always --style='numbers,changes,grid,rule,snip' -- "${FILE_PATH}" && exit 5
            exit 2;;

        image/vnd.djvu) # {{{2
			## DjVu
            ## Preview as text conversion (requires djvulibre)
            djvutxt "${FILE_PATH}" | fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        image/*) # {{{2
			## Image
            ## Preview as text conversion
            # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 4
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        video/* | audio/*) # {{{2
			## Video and audio
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
		# }}}2
    esac
} # }}}1

handle_fallback() { # {{{
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
} # }}}

MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
    handle_image "${MIMETYPE}"
fi
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
