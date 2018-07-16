package cn.com.app.common;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;

public class AES {
	//登录密码,手机号,身份证,加密
		public static final String AES_KEY = "financeX98AF32Qe";
		public static final String AES_IV = "financeX98AF32Qe";
	    public static String encrypt(String data) throws Exception {
	        try {
	            String key = AES_KEY;
	            String iv = AES_IV;

	            Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
	            int blockSize = cipher.getBlockSize();

	            byte[] dataBytes = data.getBytes();
	            int plaintextLength = dataBytes.length;
	            if (plaintextLength % blockSize != 0) {
	                plaintextLength = plaintextLength + (blockSize - (plaintextLength % blockSize));
	            }

	            byte[] plaintext = new byte[plaintextLength];
	            System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

	            SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
	            IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

	            cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
	            byte[] encrypted = cipher.doFinal(plaintext);

	            return new sun.misc.BASE64Encoder().encode(encrypted);

	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }

	    public static String decrypt(String data) throws Exception {
	        try {
	            String key = AES_KEY;
	            String iv = AES_IV;

	            byte[] encrypted1 = new BASE64Decoder().decodeBuffer(data);

	            Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
	            SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
	            IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

	            cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);

	            byte[] original = cipher.doFinal(encrypted1);
	            String originalString = new String(original);
	            return originalString.trim();
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }

	    public static void main(String args[]) throws Exception {
//	        //String data = "15224430791,18511638314,18511638314";m1+OisVqS5QeaqZviCT3JA==,VziynqXD4rnQD8BZsUdxpA==,VziynqXD4rnQD8BZsUdxpA==
	    	String data = "admin";
//	    	String data = "15020719930216382X";
	      String encryptData = encrypt(data);
	        //encryptData = "BBNuiaf4zY756bdsUt0imw==";
	        //System.out.println(data);
	      System.out.println(encryptData);
	      	//3nImnJMkBv1oMjVeBjkxYw==
	      	//EcwwZRR3wC6gwZawskPFA==
	      	//BBNuiaf4zY756bdsUt0imw==
	       System.out.println(decrypt(encryptData));
	       
//	       String s = "123456,wwwwww,eeeeee,rrrrrr,aaaaaa,ssssss,dddddd,ffffff,gggggg,aaaaaa,aaaaaa,hhhhhh,qqqwww,wwweee,eeerrr,9018,965321,111111zZ,111111zZ,wwwrrr,eeewww,tttttt,9018,test11,yyyytt,ttttee,qqqqqw,123456,QWEasd,wk123456,9018,xiaohulu123,111111,aiwen2018,bowei606,arm2018,19950708zy,SMZDMsmzdm,yunyingbu!1234,azw123456,jingdong2018,9018,BJdt123456,ctrl123456,24394272,baishan2015,jgzx123,000000,Za123456,zzidc12,woyaozan97,szis,cdht,hiklife";
//	       String[] ss = s.split(",");
//	       for(String a : ss){
//	    	   String encrypta = encrypt(a);
//	    	   System.out.println(encrypta);
//	       }
	    }

}
