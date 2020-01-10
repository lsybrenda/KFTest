package com.dxy.word.read;

import java.util.HashMap;
import java.util.Map;

import dao.OperateDao;

public class Unit {
	
	
	//获取姓名、id对应关系
	public static HashMap<String, String> getMap() {
		
		OperateDao dao = new OperateDao();
		HashMap<String, String> map = new HashMap<String, String>();
		map = dao.searchNameMap();
		
/*		map.put("雷和平","K0144");
		map.put("李中宁","K0152");
		map.put("王志云","K0204");
		map.put("袁欣","K0205");
		map.put("于家伶","K0206");
		map.put("秦璐","K0213");
		map.put("孟繁敏","K0254");
		map.put("陈娟","K0281");
		map.put("刘海燕","K0305");
		map.put("安飞","K0315");
		map.put("刘京生","K0330");
		map.put("周建军","K0331");
		map.put("王雪","K0405");
		map.put("杨益","K0444");
		map.put("罗卫平","K0445");
		map.put("裴献荣","K0446");
		map.put("杜晓晖","K0448");
		map.put("李凌","K0451");
		map.put("陈湖北","K0452");
		map.put("关琦","K0473");
		map.put("赵瑛博","K0474");
		map.put("纪安东","K0494");
		map.put("陈吉","K0509");
		map.put("王鹤","K0515");
		map.put("张宇博","K0521");
		map.put("张勇","K0538");
		map.put("范丽","K0563");
		map.put("牛新龙","K0607");
		map.put("巩子惠","K0615");
		map.put("常矛","K0616");
		map.put("于惠","K0624");
		map.put("李晓亮","K0633");
		map.put("李立","K0681");
		map.put("王延晖","K0682");
		map.put("李明霞","K0006");
		map.put("李昌峰","K0009");
		map.put("李蕾","K0012");
		map.put("魏潇潇","K0013");
		map.put("薛冬梅","K0015");
		map.put("胡翔菲","K0017");
		map.put("张宁","K0018");
		map.put("李和辛","K0020");
		map.put("郑淑香","K0021");
		map.put("荣胜男","K0024");
		map.put("马可","K0026");
		map.put("叶继平","K0027");
		map.put("刘永利","K0028");
		map.put("苑铁镔","K0031");
		map.put("王文晶","K0032");
		map.put("韩子丹","K0033");
		map.put("冀小强","K0035");
		map.put("徐勇","K0037");
		map.put("李隽春","K0049");
		map.put("郑红","K0051");
		map.put("程丽芳","K0052");
		map.put("戴晓宇","K0054");
		map.put("王军","K0055");
		map.put("金久亮","K0056");
		map.put("李玉龙","K0058");
		map.put("王淼","K0061");
		map.put("张兴","K0062");
		map.put("唱东颖","K0064");
		map.put("张国钢","K0077");
		map.put("王立宏","K0105");
		map.put("聂红","K0122");
		map.put("于红","K0131");
		map.put("李浩","K0132");*/
		
		
		
		return map;
	}
	
}
