/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.POJO.Person;
import java.io.FileNotFoundException;
import java.io.FileReader;
import jdk.nashorn.internal.ir.debug.JSONWriter;

/**
 *
 * @author krawler
 */
import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

//Design and implement REST API using Java with appropriate data
//storage and Java Frontend solution for the defined project.
public class PersonDAO {

    // HERE EXPECTED DB HANDLING
    // BUT FOR NOW I AM USING JSON FILE, SO IT CONTAINS FUNCTIONALITY RELATED TO IT
    private static PersonDAO personDAO;

    private PersonDAO() {

    }

    public static PersonDAO getObjct() {

        if (personDAO == null) {
            personDAO = new PersonDAO();
        }

        return personDAO;
    }

    public String insert(Person person) {

        String result = "{\"success\":false}";

        JSONObject contactDetails = new JSONObject();
//        contactDetails.put("id", 100);
        contactDetails.put("firstName", person.getfName());
        contactDetails.put("lastName", person.getlName());
        contactDetails.put("emailid", person.getEmail());
        contactDetails.put("mobilenumber", person.getMobileNo());
        contactDetails.put("active", person.getActive());

        //Add employees to list
        JSONArray userList = select();

        if (userList == null) {
            userList = new JSONArray();
        }
        userList.add(contactDetails);

        //Write JSON file
        try (FileWriter file = new FileWriter("contacts.json")) {

//            file.write(userList.toJSONString());
            file.append(userList.toJSONString());
            file.flush();
            file.close();

            result = "{\"success\":true}";

        } catch (IOException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public JSONArray select() {

        String result = null;
        JSONArray contactList = null;
        JSONParser jsonParser = new JSONParser();

        try {
            FileReader reader = new FileReader("contacts.json");
            //Read JSON file
            Object obj = jsonParser.parse(reader);
            contactList = (JSONArray) obj;
            reader.close();

        } catch (FileNotFoundException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);


        } catch (IOException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return contactList;
    }

    public String update(Person person) {

        String result = "{\"success\":false}";
        JSONArray contactList = select();
        
        JSONArray updContactList = new JSONArray();

        for (int i = 0; i < contactList.size(); i++) {

            JSONObject jsonObj = (JSONObject) contactList.get(i);

            String fName = jsonObj.containsKey("firstName") && !jsonObj.get("firstName").toString().equals("") ? jsonObj.get("firstName").toString() : "";
            String lName = jsonObj.containsKey("lastName") && !jsonObj.get("lastName").toString().equals("") ? jsonObj.get("lastName").toString() : "";
            String email = jsonObj.containsKey("emailid") && !jsonObj.get("emailid").toString().equals("") ? jsonObj.get("emailid").toString() : "";
            String mobileNo = jsonObj.containsKey("mobilenumber") && !jsonObj.get("mobilenumber").toString().equals("") ? jsonObj.get("mobilenumber").toString() : "";
            String active = jsonObj.containsKey("active") && !jsonObj.get("active").toString().equals("") ? jsonObj.get("active").toString() : "";

            JSONObject contactDetails = new JSONObject();

            if (person.getEmail().equalsIgnoreCase(email)) {

                contactDetails.put("firstName", person.getfName());
                contactDetails.put("lastName", person.getlName());
                contactDetails.put("emailid", email);
                contactDetails.put("mobilenumber", person.getMobileNo());
                contactDetails.put("active", person.getActive());
                updContactList.add(contactDetails);
            } else {

                contactDetails.put("firstName", fName);
                contactDetails.put("lastName", lName);
                contactDetails.put("emailid", email);
                contactDetails.put("mobilenumber", mobileNo);
                contactDetails.put("active", active);
                updContactList.add(contactDetails);
            }
        }

        try {
            FileWriter file = new FileWriter("contacts.json");
            file.write(updContactList.toJSONString());
            file.flush();
            file.close();

            result = "{\"success\":true}";

        } catch (IOException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public String delete(Person person) {

        String result = "{\"success\":false}";
        JSONArray contactListArr = select();

        JSONArray updContactListArr = new JSONArray();

        for (int i = 0; i < contactListArr.size(); i++) {
            JSONObject jsonObj = (JSONObject) contactListArr.get(i);
            
            String fName = jsonObj.containsKey("firstName") && !jsonObj.get("firstName").toString().equals("") ? jsonObj.get("firstName").toString() : "";
            String lName = jsonObj.containsKey("lastName") && !jsonObj.get("lastName").toString().equals("") ? jsonObj.get("lastName").toString() : "";
            String email = jsonObj.containsKey("emailid") && !jsonObj.get("emailid").toString().equals("") ? jsonObj.get("emailid").toString() : "";
            String mobileNo = jsonObj.containsKey("mobilenumber") && !jsonObj.get("mobilenumber").toString().equals("") ? jsonObj.get("mobilenumber").toString() : "";
            String active = jsonObj.containsKey("active") && !jsonObj.get("active").toString().equals("") ? jsonObj.get("active").toString() : "";

            if (!(person.getfName().equalsIgnoreCase(fName) && person.getlName().equalsIgnoreCase(lName) && person.getEmail().equalsIgnoreCase(email)
                    && person.getMobileNo().equalsIgnoreCase(mobileNo))) {

                JSONObject contactDetails = new JSONObject();

                contactDetails.put("firstName", fName);
                contactDetails.put("lastName", lName);
                contactDetails.put("emailid", email);
                contactDetails.put("mobilenumber", mobileNo);
                contactDetails.put("active", active);
                updContactListArr.add(contactDetails);
            }
        }

        try {

            FileWriter file = new FileWriter("contacts.json");
            file.write(updContactListArr.toJSONString());
            file.flush();
            file.close();

            result = "{\"success\":true}";

        } catch (IOException ex) {
            Logger.getLogger(PersonDAO.class.getName()).log(Level.SEVERE, null, ex);
        } 

        return result;
    }
}
