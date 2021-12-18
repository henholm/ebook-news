#!/usr/bin/env bash
# Update Calibre-fetched news

notifier=/usr/local/bin/terminal-notifier
calibre_folder="/Users/$USER/Calibre Library/calibre/"
dropbox_folder="/Users/$USER/Dropbox/dropbox_books"
echo "Searching for epubs in $calibre_folder."

# Delete from Calibre if older than 5 days. -mindepth ensures we don't delete the $calibre_folder directory.
find "$calibre_folder" -mindepth 1 -type d -mtime +5 -print -exec rm -rv "{}" \;

# Delete The Economist, FAZ, Le Monde, and 人民日报 from Dropbox if older than 5 days.
find "$dropbox_folder" \( -name "*The Economist*" -o -name "*Le Monde*" -o -name "*FAZ*" -o -name "*Ren Min Ri Bao*" \) -mtime +5 -type f -delete

# If new epubs exist, add them to Dropbox. Use -print0 to handle paths containing spaces.
to_copy_array=()
while IFS=  read -r -d $'\0'; do
    to_copy_array+=("$REPLY")
done < <(find "$calibre_folder" \( -name "*The Economist*.epub" -o -name "*Le Monde*.epub" -o -name "*FAZ*.epub" -o -name "*Ren Min Ri Bao*.epub" \) -type f -print0)

# Use the -n flag to not overwrite existing.
if (( ${#to_copy_array[@]} != 0 )); then
    cp -n -v "${to_copy_array[@]}" "$dropbox_folder"
fi
echo "Copied ${#to_copy_array[@]} epubs to $dropbox_folder."

# Display a MacOS notification.
$notifier -title "Update News" -subtitle "Update Calibre / Dropbox news" -message "Completed"
echo "Cron job to update news completed at $(date)."