#!/usr/bin/env bash
# 在 incoming 目录内就地整理：合并 .segments、可选展平整包上传的子目录
# 部署：/data/apk-repo/scripts/import-apks.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
INCOMING="${APK_REPO_INCOMING:-$REPO_ROOT/incoming}"

merge_segments() {
  local appdir="$1"
  for segdir in "$appdir"/.*.segments; do
    [[ -d "$segdir" ]] || continue
    local outname
    outname=$(basename "$segdir" .segments)
    outname=${outname#.}
    mapfile -t parts < <(find "$segdir" -type f -name '*.part*' | sort)
    if [[ ${#parts[@]} -eq 0 ]]; then
      rm -rf "$segdir"
      continue
    fi
    echo "  合并 $appdir/$outname (${#parts[@]} 片)"
    cat "${parts[@]}" > "$appdir/$outname"
    rm -rf "$segdir"
  done
}

process_app_dir() {
  local dir="$1"
  find "$dir" \( -name '*.apk' -o -name '*.part*' \) -print -quit | grep -q . || return 0
  merge_segments "$dir"
  echo "OK: $(basename "$dir")"
}

flatten_batch_uploads() {
  local item name dest
  shopt -s nullglob
  for item in "$INCOMING"/*; do
    [[ -d "$item" ]] || continue
    # 整包目录：incoming/downloaded_apks_xxx/com_foo/
    if find "$item" -mindepth 1 -maxdepth 1 -type d | grep -q .; then
      for sub in "$item"/*/; do
        name=$(basename "$sub")
        dest="$INCOMING/$name"
        if [[ "$sub" == "$dest/" ]]; then
          process_app_dir "$dest"
          continue
        fi
        if [[ -d "$dest" ]]; then
          cp -a "$sub." "$dest/"
        else
          mv "$sub" "$dest"
        fi
        process_app_dir "$dest"
      done
      rmdir "$item" 2>/dev/null || true
    else
      process_app_dir "$item"
    fi
  done
  shopt -u nullglob
}

main() {
  [[ -d "$INCOMING" ]] || { echo "目录不存在: $INCOMING" >&2; exit 1; }
  echo "整理 incoming: $INCOMING"
  flatten_batch_uploads
  echo "完成。应用数: $(find "$INCOMING" -mindepth 1 -maxdepth 1 -type d | wc -l)"
}

main "$@"
