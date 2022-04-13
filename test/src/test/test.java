package test;

import java.util.ArrayList;
import java.util.HashMap;

public class test {

	public static void main(String[] args) {

	     String url = "test159.jpg,26570426ec2cff73cae8635fad72e8c02.jpg,productList_sketch1.jpg,발표_사다리게임.png,26570426ec2cff73cae8635fad72e8c03.jpg";
	     
	     int num = url.lastIndexOf(",");
	     String real = url.substring(num+1);
	     System.out.println(real);
	     
	}

}
