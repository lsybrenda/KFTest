package com.dxy.dafen.jsp.action;

import java.util.ArrayList;
import java.util.HashMap;

public class SameworkBean {
	HashMap<String, ArrayList<String>> sign_idsMap = new HashMap<String, ArrayList<String>>();
	HashMap<String, ArrayList<String>> sign_usersMap = new HashMap<String, ArrayList<String>>();
	HashMap<String, ArrayList<String>> id_usersMap = new HashMap<String, ArrayList<String>>();
	HashMap<String, String> id_signMap = new HashMap<String, String>();
	public HashMap<String, ArrayList<String>> getId_usersMap() {
		return id_usersMap;
	}
	public void setId_usersMap(HashMap<String, ArrayList<String>> id_usersMap) {
		this.id_usersMap = id_usersMap;
	}
	public HashMap<String, ArrayList<String>> getSign_idsMap() {
		return sign_idsMap;
	}
	public void setSign_idsMap(HashMap<String, ArrayList<String>> sign_idsMap) {
		this.sign_idsMap = sign_idsMap;
	}
	public HashMap<String, ArrayList<String>> getSign_usersMap() {
		return sign_usersMap;
	}
	public void setSign_usersMap(HashMap<String, ArrayList<String>> sign_usersMap) {
		this.sign_usersMap = sign_usersMap;
	}
	public HashMap<String, String> getId_signMap() {
		return id_signMap;
	}
	public void setId_signMap(HashMap<String, String> id_signMap) {
		this.id_signMap = id_signMap;
	}
}
