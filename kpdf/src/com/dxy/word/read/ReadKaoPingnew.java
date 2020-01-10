package com.dxy.word.read;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;

public class ReadKaoPingnew {
	
	/**
	 * @param args
	 */
	HashMap<String, String> userMap = null;
	
	static int number=0;
	public ReadKaoPingnew(String path) {
		userMap = Unit.getMap();
		String s = "";
        try {
            if(path.endsWith(".doc")) {
                InputStream is = new FileInputStream(new File(path));
                WordExtractor ex = new WordExtractor(is);
                s = ex.getText();
                tiqu(s);
                ex.close();
            }else if (path.endsWith("docx")) {
                OPCPackage opcPackage = POIXMLDocument.openPackage(path);
                POIXMLTextExtractor extractor = new XWPFWordExtractor(opcPackage);
                s = extractor.getText();
                tiqu(s);
                extractor.close();
            }else {
                System.out.println("�����word�ļ�����ȷ:"+path);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	private void tiqu(String s) {
		String[] strs = s.split("\n");
		String name = "";
		ArrayList<String> yejimubiaoList = new ArrayList<String>();
		boolean isyejimubiao = false;
		for (int i = 0; i < strs.length; i++) {
			String line = strs[i];
			if(isyejimubiao){
				if(line.startsWith("�÷�С��")){
					break;
				}
				if(line.startsWith("������������")||line.startsWith("������������")){
					break;
				}
				if(line.indexOf("4��5����ԽĿ��")!=-1){
					line = line.substring(0, line.indexOf("4��5����ԽĿ��"));
				}
				if(line.indexOf("4-5����ԽĿ��")!=-1){
					line = line.substring(0, line.indexOf("4-5����ԽĿ��"));
				}
				line = line.trim();
				if(!line.equals("")){
					number++;
					yejimubiaoList.add(line);
				}
				continue;
			}
			if(line.startsWith("����")&&line.indexOf("����")!=-1){
				name = line.substring(2, line.indexOf("����")).trim();
			}
			if(line.equals("Ŀ��ϸ��\t������10��Ϊ��߷֣�\r")){
				isyejimubiao = true;
			}
			if(line.startsWith("Ŀ��ϸ��")){
				isyejimubiao = true;
			}
		}
		String userid = userMap.get(name);
		
		//System.out.println(name+"	"+userid);
		
		DecimalFormat df = new DecimalFormat("00");
		String samewordid  = "";
		String ss = "";
		
		for (int i = 0; i < yejimubiaoList.size(); i++) {
			samewordid = "";
			ss = "";
			String value = yejimubiaoList.get(i).replaceAll("\\s", "");
			if(value.endsWith("��")){
				ss = value.substring(value.length()-7);
				samewordid = ss.substring(1, 7);
				value = value.substring(0,value.length()-7);
			}
			
			String num = df.format(i+1);
			String exa_id = "2020A"+userid+num;
			System.out.println(exa_id + "	" + value+"	"+userid+"	"+samewordid);
			
		}
	}

	public static void main(String[] args) {
		File dir = new File("kp");
		File[] files = dir.listFiles();
		for (int i = 0; i < files.length; i++) {
			File file = files[i];
			new ReadKaoPingnew(file.getAbsolutePath());
			//System.out.println(i);
		}
		//System.out.println(number);
	}
	
}
