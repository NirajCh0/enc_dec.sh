#!/bin/bash

# Function to encrypt the file
encrypt_file() {
    local file="$1"
    local public_key="$2"
    local encrypted_file="$file.enc"

    # Encrypt the file using the public key
    openssl rsautl -encrypt -pubin -inkey "$public_key" -in "$file" -out "$encrypted_file"
    echo "File encrypted successfully. Encrypted file: $encrypted_file"
}

# Function to decrypt the file
decrypt_file() {
    local encrypted_file="$1"
    local private_key="$2"
    local decrypted_file="${encrypted_file%.enc}.decrypted"

    # Decrypt the file using the private key
    openssl rsautl -decrypt -inkey "$private_key" -in "$encrypted_file" -out "$decrypted_file"
    echo "File decrypted successfully. Decrypted file: $decrypted_file"
}

# Main function
main() {
    local mode="$1"
    local file="$2"
    local key="$3"

    # Check if mode is encryption or decryption
    if [ "$mode" == "encrypt" ]; then
        encrypt_file "$file" "$key"
    elif [ "$mode" == "decrypt" ]; then
        decrypt_file "$file" "$key"
    else
        echo "Invalid mode. Usage: $0 [encrypt|decrypt] <file> <key>"
        exit 1
    fi
}

# Call main function with command-line arguments
main "$@"
