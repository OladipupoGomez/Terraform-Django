terraform { 
  cloud { 
    
    organization = "Devops-Project-Django101" 

    workspaces { 
      name = "monitoring-cloudwatch-development" 
    } 
  } 
}