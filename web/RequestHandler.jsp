<%@page import="com.ViewAction.ContactsViewAction"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String cmd = request.getParameter("cmd");
    int docmd = request.getParameter("docmd") != null ? Integer.parseInt(request.getParameter("docmd").toString()) : -1;

    String result = "";

    if (cmd.equals("manageContacts")) {

        switch (docmd) {
            case 1: // add
                result = ContactsViewAction.addContact(request, response);
                break;
            case 2: // edit
                ContactsViewAction.editContact(request);
                break;

            case 3: // delete
                result = ContactsViewAction.deleteContact(request);
                break;

            case 4: // select
                result = ContactsViewAction.selectContact(request);
                break;
        }
    } else {
        
    }

    out.print(result);
    out.flush();
%>
