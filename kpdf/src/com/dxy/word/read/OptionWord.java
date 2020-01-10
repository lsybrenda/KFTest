package com.dxy.word.read;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;

/** 
 * @author QiaoJiafei 
 * @version 创建时间：2016年2月22日 上午11:30:04 
 * 类说明 
 */
public class OptionWord {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	readWord("kp\\无额定任务量员工考核评估表_戴晓宇_2016上半年.doc");
    }
    
    public static StringBuffer readWord(String path) {
        String s = "";
        try {
            if(path.endsWith(".doc")) {
                InputStream is = new FileInputStream(new File(path));
                WordExtractor ex = new WordExtractor(is);
                s = ex.getText();
                System.out.println(s);
                ex.close();
            }else if (path.endsWith("docx")) {
                OPCPackage opcPackage = POIXMLDocument.openPackage(path);
                POIXMLTextExtractor extractor = new XWPFWordExtractor(opcPackage);
                s = extractor.getText();
                extractor.close();
            }else {
                System.out.println("传入的word文件不正确:"+path);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        StringBuffer bf = new StringBuffer(s);
        return bf;
    }

}