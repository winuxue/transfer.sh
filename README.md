# transfer&#46;sh - bash script

Defines an alias to share file(s) and folder using transfer.sh

## Installation 
```sh
git clone https://github.com/winuxue/transfer.sh.git

cd transfer.sh

cat transfer.sh >> ~/.bashrc
```
## optional requirements
- **xclip**: allows copy the generated link to your clipboard.

## Usage
- for single file
```sh
transfer document.pdf
```
- for two or more files
```sh
transfer document1.pdf document2.pdf
```
- for files with spaces in it's name
```sh
transfer "document 1.pdf"
```
- for directories
```sh
transfer mydir
```