package com.dxy.word.read;

import java.util.HashMap;
import java.util.Map;

import dao.OperateDao;

public class Unit {
	
	
	//��ȡ������id��Ӧ��ϵ
	public static HashMap<String, String> getMap() {
		
		OperateDao dao = new OperateDao();
		HashMap<String, String> map = new HashMap<String, String>();
		map = dao.searchNameMap();
		
/*		map.put("�׺�ƽ","K0144");
		map.put("������","K0152");
		map.put("��־��","K0204");
		map.put("Ԭ��","K0205");
		map.put("�ڼ���","K0206");
		map.put("���","K0213");
		map.put("�Ϸ���","K0254");
		map.put("�¾�","K0281");
		map.put("������","K0305");
		map.put("����","K0315");
		map.put("������","K0330");
		map.put("�ܽ���","K0331");
		map.put("��ѩ","K0405");
		map.put("����","K0444");
		map.put("����ƽ","K0445");
		map.put("������","K0446");
		map.put("������","K0448");
		map.put("����","K0451");
		map.put("�º���","K0452");
		map.put("����","K0473");
		map.put("������","K0474");
		map.put("�Ͱ���","K0494");
		map.put("�¼�","K0509");
		map.put("����","K0515");
		map.put("���","K0521");
		map.put("����","K0538");
		map.put("����","K0563");
		map.put("ţ����","K0607");
		map.put("���ӻ�","K0615");
		map.put("��ì","K0616");
		map.put("�ڻ�","K0624");
		map.put("������","K0633");
		map.put("����","K0681");
		map.put("������","K0682");
		map.put("����ϼ","K0006");
		map.put("�����","K0009");
		map.put("����","K0012");
		map.put("κ����","K0013");
		map.put("Ѧ��÷","K0015");
		map.put("�����","K0017");
		map.put("����","K0018");
		map.put("�����","K0020");
		map.put("֣����","K0021");
		map.put("��ʤ��","K0024");
		map.put("���","K0026");
		map.put("Ҷ��ƽ","K0027");
		map.put("������","K0028");
		map.put("Է����","K0031");
		map.put("���ľ�","K0032");
		map.put("���ӵ�","K0033");
		map.put("��Сǿ","K0035");
		map.put("����","K0037");
		map.put("������","K0049");
		map.put("֣��","K0051");
		map.put("������","K0052");
		map.put("������","K0054");
		map.put("����","K0055");
		map.put("�����","K0056");
		map.put("������","K0058");
		map.put("���","K0061");
		map.put("����","K0062");
		map.put("����ӱ","K0064");
		map.put("�Ź���","K0077");
		map.put("������","K0105");
		map.put("����","K0122");
		map.put("�ں�","K0131");
		map.put("���","K0132");*/
		
		
		
		return map;
	}
	
}
