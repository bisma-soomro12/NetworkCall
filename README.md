# MaqsadAssignment
This Assignment contain two components i.e. SearchComponentVC and ResultComponentVC. In SearchComponentVC there is a textfield and button to initiate the
api call for search string and when the response is back from api it will show in ResultComponentVC where three coloumns from data response is added in table
vview and if there is no data resturn it will show the alert box and resturn to the SearchComponentVC

# BuildProcedure 
app is launch and first screen which is shown is SearchComponentVC and empty string will not be send to api call if string value is not empty then submit
button will initiate the api call and response will be parse to the codeable struct file and then response is passed to ResultComponentVC and i have used pod file for image url if you get compile time error for podfile please install the pod again 
