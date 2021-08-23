 
    ####################################################
#### Removes all fields containing .co.uk in a wordlist ####
    ####################################################    
Get-Content 'C:\Dir\couk.txt' | 
Where-Object {$_ -notmatch ".co.uk"} | Set-Content 'C:\Dir\1dotremove.txt'
    ##########################################################
#### Saves all fields containing .co.uk to a seperate wordlist ####
    ##########################################################
Get-Content 'C:\Dir\couk.txt' | 
Where-Object {$_ -match ".co.uk"} | Set-Content 'C:\Dir\2dotremove.txt'


$2dotlist = 'C:\Dir\2dotremove.txt'

$1dotlist = 'C:\Dir\1dotremove.txt'


    ##############################################
#### Filters all the 1 '.'' out of the 1 '.'' list ####
    ##############################################
Get-Variable 'C:\Dir\1dotremove.txt' | 
Where-Object -FilterScript { $_ -match "\w*\.\w*\.\w*" } | #1 '.' removal (.net,ie,.com,.org etc.)#   
Set-Content 'C:\Dir\output1dot.txt'
    ##############################################
#### Filters all the 2 '.'' out of the 2 '.'' list ####
    ##############################################
Get-Content 'C:\Dir\2dotremove.txt' | 
Where-Object -FilterScript { $_ -match "\w*\.\w*\.\w*\.\w*" } | #2 '.' removal (.co.uk)
Set-Content 'C:\Dir\output2dot.txt'



