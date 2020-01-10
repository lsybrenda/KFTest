package com.dxy.word.read;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;

public class ReadKaoPing {
	
	/**
	 * @param args
	 */
	public ReadKaoPing(String path) {
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
                System.out.println("传入的word文件不正确:"+path);
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
				if(line.startsWith("得  分  小  计")){
					break;
				}
				String str= line.substring(0,line.indexOf("□ □ □ □ □"));
				yejimubiaoList.add(str);
				continue;
			}
			if(line.startsWith("姓名")&&line.indexOf("部门")!=-1){
				name = line.substring(2, line.indexOf("部门")).trim();
			}
			if(line.equals("目标细分\t1  2  3  4  5\t评分说明\r")){
				isyejimubiao = true;
			}
		}
		System.out.println(name);
		for (int i = 0; i < yejimubiaoList.size(); i++) {
			String value = yejimubiaoList.get(i);
			System.out.println(value);
		}
	}

	public static void main(String[] args) {
		File dir = new File("kp");
		File[] files = dir.listFiles();
		for (int i = 0; i < files.length; i++) {
			File file = files[i];
			new ReadKaoPing(file.getAbsolutePath());
		}
	}
	
}
