<# ------------------------------------------------------------------------------------ #
    PowerShell Script to generate & populate BulkAddUsersList.xlsx entries
    
    All the information is not real & only for replicating the process of creating
    numerous users on Active Directory from a bulk excel sheet. We will convert it
    to a csv file once we've populated the excel sheet first.
#> 


# ---------- Edit these Variables ----------------------------------------------------- #

$USER_FIRST_LAST_LIST = Get-Content .\names.txt
$PASSWORD_LIST = Get-Content .\passwords.txt
$EXCEL_FILE_PATH = '.\BulkAddUsersList.xlsx'

$department = "IT"
$phone = "123-456-7890"
$company = "My Company Inc."
$OU = "_USERS"
$domain = "mydomain.com"

# ------------------------------------------------------------------------------------- #


# ----- Create excel object to open and edit ------------------------------------------ #

$excel = New-Object -ComObject excel.application
$workbook = $excel.Workbooks.Open($EXCEL_FILE_PATH)
$excel.Visible = $true
$Data = $workbook.Worksheets.Item(1)
$Data.Name = 'BulkAddUsersList'

# ------------------------------------------------------------------------------------- #


# ----- Function to create random addresses from selection ---------------------------- #

function generate_random_address() {
    $choice = Get-Random -Minimum 1 -Maximum 5
    $fullAddress = ""
    Switch ($choice) {
            1 {$fullAddress = "123 Fake Boulevard,Fredericton,NB,Canada,F3C 1N2"}
            2 {$fullAddress = "45 Fib Road,Dorchester,NB,Canada,F5J 1S5"}
            3 {$fullAddress = "678 Macnotastreet Avenue,Moncton,NB,Canada,F1H 2S7"}
            4 {$fullAddress = "910 Cantsee Street,Saint John,NB,Canada,F2L 2H3"}
        }
        return $fullAddress
}

# ------------------------------------------------------------------------------------ #


# ----- Function to generate work title from selection ------------------------------- #

function generate_random_title() {
    $choice = Get-Random -Minimum 1 -Maximum 9
    $title = " "
    Switch ($choice) {
            1 {$title = "IT Helpdesk Analyst"}
            2 {$title = "System Administrator"}
            3 {$title = "IT Helpdesk Analyst"}
            4 {$title = "Cybersecurity Engineer"}
            5 {$title = "IT Helpdesk Analyst"}
            6 {$title = "System Administrator"}
            7 {$title = "IT Helpdesk Analyst"}
            8 {$title = "Cybersecurity Analyst"}
            9 {$title = "IT Helpdesk Analyst"}
        }
        return $title
}

# ------------------------------------------------------------------------------------ #


# ----- loops through each name entry in names.txt file ------------------------------ #

$a = 2
foreach ($name in $USER_FIRST_LAST_LIST) {
    $address = ""
    $address = generate_random_address
    $jobTitle = generate_random_title

    $first = $name.Split(" ")[0]
    $last = $name.Split(" ")[1]
    $initials = $first[0] + $last[0]
    $username = "$($first.Substring(0,1))$($last)"
    $email = $username + "@" + $domain
    
    $addressArray = $address.Split(",")
    $street = $addressArray[0]
    $city = $addressArray[1]
    $zip = $addressArray[4].ToUpper()
    $state = $addressArray[2].ToUpper()
    $country = $addressArray[3]

    $Data.Cells.Item($a, 1) = $first
    $Data.Cells.Item($a, 2) = $last
    $Data.Cells.Item($a, 3) = "$($initials.ToUpper())"
    $Data.Cells.Item($a, 4) = $username
    $Data.Cells.Item($a, 5) = $email
    $Data.Cells.Item($a, 6) = $street
    $Data.Cells.Item($a, 7) = $city
    $Data.Cells.Item($a, 8) = $zip
    $Data.Cells.Item($a, 9) = $state
    $Data.Cells.Item($a, 10) = $country
    $Data.Cells.Item($a, 11) = $department
    $Data.Cells.Item($a, 13) = $phone
    $Data.Cells.Item($a, 14) = $jobTitle
    $Data.Cells.Item($a, 15) = $company
    $Data.Cells.Item($a, 16) = $OU

    $a = $a + 1
}

# ------------------------------------------------------------------------------------ #


# ----- loops through each password entry in passwords.txt file ---------------------- #

$a = 2
foreach($password in $PASSWORD_LIST) {
    $Data.Cells.Item($a, 12) = $password
    $a = $a + 1
}

# ------------------------------------------------------------------------------------ #


# ----- Formats & saves the excel file ----------------------------------------------- #

$usedRange = $Data.UsedRange
$usedRange.EntireColumn.AutoFit() | Out-Null
$workbook.SaveAs

# ------------------------------------------------------------------------------------ #