This script automates collecting contributor names and emails from multiple GitHub projects.
It reads repository links from a file, clones them, extracts contributor data from the commit history, and saves the results in a file called developers.txt. Duplicate entries are automatically skipped.

How it works :

    1.Add GitHub repository links to Links.txt (one per line).

    2. Run the script to 

        - Clone each repo

        - Extract contributor names and emails

        - Save the data in developers.txt

Requirements :

    - Bash shell

    - Git installed and configured 

Usage :

    1. Make sure the script and Links.txt are in the same folder.

    2.Run 

        chmod +script_name.sh

        ./script_name.sh

    3. Open developers.txt to view the results

The script helps streamline repetitive tasks when working with multiple GitHub projects.
