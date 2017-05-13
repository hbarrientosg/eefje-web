properties {
  $envPath = "../.env"
  $backup = "./backup.sql"
}

task default -depends Pull

task Pull -depends LoadEnv,SetProductionDB,Backup,SetLocalDB,Restore,SetURLForLocalDB {}
task Push -depends LoadEnv,SetLocalDB,SetURLForProductionDB,Backup,SetURLForLocalDB,SetProductionDB,Restore {}

task LoadEnv {
  Select-String '([^=]*)=(.*)' $envPath | % {
    Invoke-Expression ('$script:{0}="{1}"' -f ($_.Matches.Groups[1].Value -as [string]), ($_.Matches.Groups[2].Value -as [string]))
  }
}

task SetLocalDB {
  $script:JAWSDB_MARIA_URL -match 'mysql:\/\/([^:]*):([^@]*)@([^:]*):([^\/]*)\/(.*)'

  $script:host = ($Matches[3] -as [string])
  $script:username = ($Matches[1] -as [string])
  $script:password = ($Matches[2] -as [string])
  $script:db = ($Matches[5] -as [string])
}

task SetProductionDB {
  $script:JAWSDB_MARIA_SERVER_URL -match 'mysql:\/\/([^:]*):([^@]*)@([^:]*):([^\/]*)\/(.*)'

  $script:host = ($Matches[3] -as [string])
  $script:username = ($Matches[1] -as [string])
  $script:password = ($Matches[2] -as [string])
  $script:db = ($Matches[5] -as [string])
}

task SetURLForProductionDB {
  $sql = '"update wp_options set option_value=''{0}'' where option_name IN (''siteurl'', ''home'');"' -f $script:SERVER_URL

  Invoke-Expression ('mysql -h {0} -u {1} -p{2} {3} -e {4}' -f $script:host,$script:username,$script:password,$script:db,$sql)
}

task SetURLForLocalDB {
  $sql = '"update wp_options set option_value=''{0}'' where option_name IN (''siteurl'', ''home'');"' -f $script:LOCAL_URL

  Invoke-Expression ('mysql -h {0} -u {1} -p{2} {3} -e {4}' -f $script:host,$script:username,$script:password,$script:db,$sql)
}

task Restore {
  Invoke-Expression ('Get-Content {4} | mysql -h {0} -u {1} -p{2} {3}' -f $script:host,$script:username,$script:password,$script:db,$backup)
  Remove-Item $backup
}

task Backup {
  Invoke-Expression ('mysqldump -h {0} -u {1} -p{2} {3} > {4}' -f $script:host,$script:username,$script:password,$script:db,$backup)
}
