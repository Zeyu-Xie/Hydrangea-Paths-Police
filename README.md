# Hydrangea-Paths-Police

A tool for checking unsupported file names.

## File / Folder Name Rules

### Windows

1. Forbidden printable ASCII characters

   ```
   < (less than)
   > (greater than)
   : (colon - sometimes works, but is actually NTFS Alternative Data Streams)
   " (double quote)
   / (forward slash)
   \ (backslash)
   | (vertical bar or pipe)
   ? (question mark)
   * (asterisk)
   ```

2. Forbidden non-printable characters

   ```
   0-31 (ASCII control characters)
   ```

3. Reserved file names (both on their own and with arbitrary file extensions)

   ```
   CON, PRN, AUX, NUL
   COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9
   LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, LPT9
   ```

4. Other rules

   1. Filenames cannot end in a space or dot.

### Linux / Unix

1. Forbidden printable ASCII characters

   ```
   / (forward slash)
   ```

2. Forbidden non-printable characters

   ```
   0 (NULL byte)
   ```

3. Reserved file names (both on their own and with arbitrary file extensions)

   ```
   . (special name referring to current directory)
   .. (special name referring to parent directory)
   ```

4. Other rules

   1. Colon `:` and forward slash `/` depending on context are not permitted (e.g. Finder supports slashes, terminal supports colons).

## Referrences

1. [What characters are forbidden in Windows and Linux directory names? - Stack Overflow](https://stackoverflow.com/questions/1976007/what-characters-are-forbidden-in-windows-and-linux-directory-names)
2. [macos - What are invaild characters for a file name under os X? - Super User](https://superuser.com/questions/326103/what-are-invalid-characters-for-a-file-name-under-os-x)
