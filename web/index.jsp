<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.ViewAction.ContactsViewAction"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String contactList = ContactsViewAction.selectContact(request);
    Object obj = null;
    JSONArray contactListArr = null;
    
    if (contactList!=null && !contactList.trim().equals("")) {
        JSONParser jsonParser = new JSONParser();
        obj = jsonParser.parse(contactList);
        contactListArr = (JSONArray) jsonParser.parse(contactList);    
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Contact</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <h5 style="color:white">Manage Contacts</h5>
        </nav><br>
        <div class="row" width="100%">
            <div class="col-sm-3">
                <div class="container">
                    <form id="frmContacts" name="frmContacts">
                        <input type ="hidden" name="cmd" id="cmd" value="manageContacts" />
                        <input type ="hidden" name="docmd" id="docmd" value="4" /> <!-- 1:add   2:edit   3:delete   4:select -->
                        <input type ="hidden" name="contactemail" id="contactemail" value="" />

                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="contactFName" id="contactFName" class="form-control" placeholder="First Name" size="20px" pattern="[a-zA-Z]+" 
                                   title="Please enter valid First Name."  required/>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="contactLName" id="contactLName" class="form-control" placeholder="Last Name" size="20px" pattern="[a-zA-Z]+" 
                                   title="Please enter valid First Name." required/>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="emailid" id="emailid" class="form-control" placeholder="Email"
                                   title="Please enter emailid" size="20px" required/>
                        </div>
                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="text" pattern="[2-9]{1}[0-9]{9}" name="mobileNumber" id="mobileNumber" class="form-control" placeholder="Mobile Number" 
                                   title="Please enter mobile number"  maxlength="10"  required>
                        </div>
                        <div class="form-group" align="right">
                            <input class="form-check-input" type="checkbox" name="active" id="active">
                            <label class="form-check-label" for="defaultCheck1">Active</label>
                        </div>

                        <div class="form-group" align="right">
                            <button type="button" class="btn btn-info" id="btnSave" name="btnSave" onclick="addContact()">Add</button>
                            <button type="button" class="btn btn-info" id="btnReset" name="btnReset" onclick="resetForm()">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="panel-body">
                    <INPUT TYPE="button" onClick="refreshPage()" VALUE="Refresh" class="btn btn-info"> <br>
                    <table id="tbl-Contacts" name="tbl-Contacts" class="table table-bordered" cellpadding="0" cellspacing="0" width="100%">
                        <thead>
                            <tr align="center">
                                <th>Name</th>
                                <th>Email</th>
                                <th>Mobile No.</th>
                                <th>Active</th>
                                <th></th>
                                <th></th>
                                <!--<th></th>-->
                            </tr>
                        </thead>
                        <tbody>
<%
                            if (contactList != null && !contactList.trim().equals("")) {
                                for (int i = 0; i < contactListArr.size(); i++) {
                                    JSONObject jsonObj = (JSONObject) contactListArr.get(i);
                                    
                                    String fName = jsonObj.containsKey("firstName") && !jsonObj.get("firstName").toString().equals("") ? jsonObj.get("firstName").toString() : "";
                                    String lName = jsonObj.containsKey("lastName") && !jsonObj.get("lastName").toString().equals("") ? jsonObj.get("lastName").toString() : "";
                                    String email = jsonObj.containsKey("emailid") && !jsonObj.get("emailid").toString().equals("") ? jsonObj.get("emailid").toString() : "";
                                    String mobileNo = jsonObj.containsKey("mobilenumber") && !jsonObj.get("mobilenumber").toString().equals("") ? jsonObj.get("mobilenumber").toString() : "";
                                    String active = jsonObj.containsKey("active") && !jsonObj.get("active").toString().equals("") ? jsonObj.get("active").toString() : "";
%>
                                    <tr>
                                        <td><%=(fName + " " + lName)%></td>
                                        <td><%=email%></td>
                                        <td><%=mobileNo%></td>
                                        <td align="center"><%=active%></td>
                                        <td align="center">
                                            <button class='btn btn-info' onclick="eidtContact('<%=fName%>', '<%=lName%>', '<%=email%>', '<%=mobileNo%>', '<%=active%>')"> Edit </button>
                                        </td>
                                        <td align="center">
                                            <button class="btn btn-danger" onclick="deleteContact('<%=fName%>', '<%=lName%>', '<%=email%>', '<%=mobileNo%>', '<%=active%>')"> Delete </button>
                                        </td>
                                    </tr>
<%
                                }
                            } else {
%>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
<%
                            }
%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="component/jquery/jquery.js" type="text/javascript"></script>
        <script src="component/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="component/jquery.validate.min.js" type="text/javascript"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="component/Other/jquery.dataTables.min.js" type="text/javascript"></script>

        <script type="text/javascript">
                    var isNew = true;

                    function refreshPage(){
                        window.location.reload();
                    } 

                    function addContact() {

                        if ($("#frmContacts").valid()) {
                            document.getElementById("docmd").value = "1";
//                            alert("OK");
                            var url = "RequestHandler.jsp";
                            var data = $("#frmContacts").serialize();
                            var cmd = "manageContacts";
                            var method = "POST";
                            if (isNew) {
                                docmd = "1";
                                method = "POST";
                            } else {
                                document.getElementById("docmd").value = "2";
                                data = $("#frmContacts").serialize();
                            }
                            $.ajax({
                                type: method,
                                url: url,
                                dataType: 'JSON',
                                data: data,
                                cmd: "manageContacts",
                                docmd: docmd,
                                function (data) {
                                    if (isNew) {
                                        alert("Contact Added Successfully.");
                                    } else {
                                        alert("Contact Updted Successfully.");
                                    }
                                    resetForm();
                                }
                            });
                        } else {
                            alert("Please Enter Required Details.");
                        }
                    }

            function resetForm() {
                isNew = true;
                document.getElementById("docmd").value = "1";
                document.getElementById("contactFName").value = "";
                document.getElementById("contactLName").value = "";
                document.getElementById("emailid").value = "";
                document.getElementById("mobileNumber").value = "";
                document.getElementById("active").checked = false;
                document.getElementById("contactFName").focus();
                document.getElementById("contactemail").value = emailid;
                document.getElementById("emailid").readOnly = false;
                document.getElementById("btnSave").innerHTML = "Save";
            }
            
            function eidtContact(firstName, lastName, emailid, mobileNum, act) {
                isNew = false;
                document.getElementById("contactFName").value =firstName;
                document.getElementById("contactLName").value = lastName;
                document.getElementById("emailid").value = emailid;
                document.getElementById("emailid").readOnly = true;
                document.getElementById("mobileNumber").value = mobileNum;
                document.getElementById("active").checked = (act=='YES'?true:false);
                document.getElementById("docmd").value = "2";
                document.getElementById("contactemail").value = emailid;
                document.getElementById("btnSave").innerHTML = "Update";
            }

            function confirm_decision(user_id){
                if (confirm("you want to delete contact?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
                {
                    window.location="deleteStaffAction.jsp?userID="+user_id; 
                    return true;
                } else {
                    return false;
                }
            }

            function deleteContact(firstName, lastName, emailid, mobileNum, act) {
                
                if (confirm("you want to delete contact?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
                {
                    document.getElementById("docmd").value = "3";
                    var url = "RequestHandler.jsp?cmd=manageContacts&docmd=3&firstName="+firstName+"&lastName="+lastName+"&emailid="+emailid+"&mobileNum="+mobileNum+"&active="+act;
                    var method = "POST";
                    $.ajax({
                        type: method,
                        url: url,
                        dataType: 'JSON',
                        function (data) {
                            alert("Contact Deleted Successfully.");
                        }
                    });
                }                
            }
            
        </script>
    </body>
</html>
