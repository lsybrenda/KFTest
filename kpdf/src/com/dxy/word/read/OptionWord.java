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
 * @version ����ʱ�䣺2016��2��22�� ����11:30:04 
 * ��˵�� 
 */
public class OptionWord {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	readWord("kp\\�޶������Ա������������_������_2016�ϰ���.doc");
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
                System.out.println("�����word�ļ�����ȷ:"+path);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        StringBuffer bf = new StringBuffer(s);
        return bf;
    }

}