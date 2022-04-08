package test;

import java.util.ArrayList;
import java.util.HashMap;

public class test {

	public static void main(String[] args) {
		String [] options1 = {"qwegf", "w3egvw", "dfgn"};
		String [] options2 = {"222qwegf", "222w3egvw", "222dfgn"};
		String [] options3 = {"333qwegf", "333w3egvw", "333dfgn"};
		
		ArrayList<String> optionList = new ArrayList<String>();
		
		for(int i=0; i<options1.length; i++) {
			for(int j=0; j<options2.length; j++) {
				for(int k=0; k<options3.length; k++) {
					optionList.add(options1[i] + "/" + options2[j] + "/" + options3[k]); 
				}
			}
		}
		
		for(String list : optionList)
			System.out.println(list);
		
	}

}
