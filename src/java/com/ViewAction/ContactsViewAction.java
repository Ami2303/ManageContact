/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ViewAction;

import com.DAO.PersonDAO;
import com.POJO.Person;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author krawler
 */
public class ContactsViewAction {

//    String SUCCESS_JSON = "{\"success\":true}";
//    String FAILURE_JSON = "{\"success\":false}";
    public static String addContact(HttpServletRequest request, HttpServletResponse response) {
        String result = "{\"success\":true}";

        try {

            String fName = request.getParameter("contactFName").trim();
            String lName = request.getParameter("contactLName").trim();
            String email = request.getParameter("emailid").trim();
            String phoneNo = request.getParameter("mobileNumber").trim();
            String active = request.getParameter("active").trim(); // Yes / No

            if (fName != null && lName != null && email != null && phoneNo != null) {

                Person person = new Person();
                person.setfName(fName);
                person.setlName(lName);
                person.setEmail(email);
                person.setMobileNo(phoneNo);
                person.setActive(active.equalsIgnoreCase("on") ? "YES" : "NO");

                result = PersonDAO.getObjct().insert(person);
            }
        } catch (Exception ex) {
            result = "{\"success\":true}";
        }

        return result;
    }

    public static String editContact(HttpServletRequest request) {
        
        String result = "{\"success\":true}";

        String fName = request.getParameter("contactFName").trim();
        String lName = request.getParameter("contactLName").trim();
        String email = request.getParameter("emailid") != null ? request.getParameter("emailid").trim() :request.getParameter("contactemail").trim();
        String mobileNo = request.getParameter("mobileNumber").trim();
        String active = request.getParameter("active") !=null ? request.getParameter("active").trim() : "NO"; // Yes / No

        if (fName != null && lName != null && email != null && mobileNo != null) {

            Person person = new Person();
            person.setfName(fName);
            person.setlName(lName);
            person.setEmail(email);
            person.setMobileNo(mobileNo);
            person.setActive(active.equalsIgnoreCase("on") ? "YES" : "NO");

            result = PersonDAO.getObjct().update(person);
        }

        return result;
    }

    public static String deleteContact(HttpServletRequest request) {
        String result = "{\"success\":true}";

        String fName = request.getParameter("firstName").trim();
        String lName = request.getParameter("lastName").trim();
        String email = request.getParameter("emailid").trim();
        String mobileNo = request.getParameter("mobileNum").trim();
        String active = request.getParameter("active").trim(); // Yes / No

        // firstName="+firstName+"&lastName="+lastName+"&emailid="+emailid+"&mobileNum="+mobileNum+"&active="+act;
        if (fName != null && lName != null && email != null && mobileNo != null) {

            Person person = new Person();
            person.setfName(fName);
            person.setlName(lName);
            person.setEmail(email);
            person.setMobileNo(mobileNo);
            person.setActive(active.equals("1") ? "YES" : "NO");

            result = PersonDAO.getObjct().delete(person);
        }

        return result;
    }

    public static String selectContact(HttpServletRequest request) {

        String result = "{\"success\":false}";
        JSONArray jsonArr = PersonDAO.getObjct().select();
        result = (jsonArr==null?"":jsonArr.toJSONString());

        return result;
    }
}
