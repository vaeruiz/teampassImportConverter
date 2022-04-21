# TeampassImportConverter

Fixes the formatting errors when exporting csv items in Teampass

## How to use

1. Download the csv with the items (if it redirects you to hacking attempt, click again on export objects and download, repeat until the file is downloaded).
2. Deletes the comments/description field (the csv generator change characters like ñ to N&ia for example), you can use excel or any spreadsheet processor (I also recommend removing commas and double-quotes from the file to avoid errors when converting the file).
3. Send the file to your linux system where the script is located.
4. Before using the script, make sure it has the proper execute permissions.
5. Type:
>./script.sh fileToConvertName.csv

### [Link to issue in Teampass Github](https://github.com/nilsteampassnet/TeamPass/issues/3133) 

## Note
Feel free to take the measures you see appropriate to achieve a better conversion:
