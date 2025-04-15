#!/bin/bash
set -e

files_dir="$CHEZMOI_SOURCE_DIR/files"

add_apt_repositories() {
    echo "🔄 Adding APT repositories..."
    sources_destdir="/etc/apt/sources.list.d/"
    sudo mkdir -p "$sources_destdir"
    for file in "$files_dir/sources"/*.sources; do
        [ -f "$file" ] || continue  # Skip if no .sources files exist
        # Extract KeyUrl and KeyPath from the .sources file (if they exist)
        key_url=$(grep -E "^.?Key-Url:" "$file" | awk '{print $2}' | envsubst)
        key_file=$(grep -E "^.?Key-File:" "$file" | awk '{print $2}' | envsubst)
        key_dst_path=$(grep -E "^Signed-By:" "$file" | awk '{print $2}' | envsubst)
        dearmor=$(grep -E "^.Dearmor:" "$file" | awk '{print $2}')
        if [[ -n "$key_dst_path" ]]; then
            sudo mkdir -p "$(dirname "$key_dst_path")"  # Ensure the key directory exists
            if [[ -n "$key_url" ]]; then
                echo "Downloading GPG key from $key_url to $key_dst_path..."
                sudo wget -q "$key_url" -O "$key_dst_path"
            elif [[ -n "$key_file" ]]; then
                echo "Copying GPG key from $key_file to $key_dst_path..."
                sudo install -v -o root -g root -m 644 "$key_file" "$key_dst_path"
            else 
                echo "No Key-Url or Key-File found for $file. Skipping key installation."
                continue
            fi
            # Convert to binary format if required
            if [[ "$dearmor" == "Yes" ]]; then
                echo "Dearmoring GPG Key..."
                sudo gpg --dearmor "$key_dst_path"
                sudo mv "${key_dst_path}.gpg" "$key_dst_path"
            fi
            # Set correct ownership and permissions
            sudo chown root:root "$key_dst_path"
            sudo chmod 644 "$key_dst_path"
            echo "Key downloaded and installed: $key_dst_path"
        fi
        # Install the .sources file
        sudo install -v -o root -g root -m 644 "$file" "$sources_destdir"
        echo "Installed: $(basename "$file")"
    done
}

# Call the function
add_apt_repositories

# Update package lists
echo "🔄 Updating APT sources..."
sudo apt update

# Remove not needed packages
sudo apt remove -y --autoremove --ignore-missing $(tr '\n' ' ' < "$files_dir/remove_packages.list")

# Install missing packages
sudo apt install -y --ignore-missing $(tr '\n' ' ' < "$files_dir/install_packages.list")
