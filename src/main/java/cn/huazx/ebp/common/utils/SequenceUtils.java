package cn.huazx.ebp.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.net.NetworkInterface;
import java.security.MessageDigest;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Scanner;

public class SequenceUtils {
	  
    private static String getMD5(String message) {
        message += "{huazxEBP}";
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] b = md.digest(message.getBytes("utf-8"));
            String md5 = h(b)+message.length();
            return md5;
        } catch (Exception e) {
			System.out.println("MD5摘要失败");
        }
        return null;
    }
    private static String h(byte[] b) {
        char[] hex = {'0', '1', '2', '3', '4', '5', '6', '7',
            '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        char[] newChar = new char[b.length * 2];
        for (int i = 0; i < b.length; i++) {
            newChar[2 * i] = hex[(b[i] & 0xf0) >> 4];
            newChar[2 * i + 1] = hex[b[i] & 0xf];
        }
        return new String(newChar);
    }
   
    private static String s() {
    	try{
    		 Properties props = System.getProperties();
       	  	 StringBuffer result = new StringBuffer("[");
             String osName = props.getProperty("os.name");
             result.append(osName+",");
             String osVersion = props.getProperty("os.version");
             result.append(osVersion+",");
             result.append(getMAC()+"]");
             String machineCode = getMD5(result.toString());
             return machineCode;
    	}catch(Throwable ex){
    		ex.printStackTrace();
    	}
         String defaultInfo = getDefault();
         return getMD5(defaultInfo);
    }
    private static String getMAC()
	{
		StringBuffer f = new StringBuffer();
		try {
			Enumeration<NetworkInterface> e = NetworkInterface.getNetworkInterfaces();
			while (e.hasMoreElements())
			{
				NetworkInterface network;
				if ((
						network = (NetworkInterface)e.nextElement()) != null)
				{
					if (network.getHardwareAddress() != null)
					{
						byte[] addres = network.getHardwareAddress();
						StringBuffer sb = new StringBuffer();
						if ((addres != null) && (addres.length > 1)) {
							sb.append(toHexString(addres[0])).append(
									toHexString(addres[1])).append(
									toHexString(addres[2])).append(
									toHexString(addres[3])).append(
									toHexString(addres[4])).append(
									toHexString(addres[5]));
							if (!sb.toString().equals("000000"))
								f.append(sb.toString());
						}
					}
				}
				else
					System.out.println("获取MAC地址失败");
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return f.toString();
	}
    private static String c()
	  {
    	 String str = "";
    	    try
    	    {
    	      Process localProcess = Runtime.getRuntime().exec(new String[] { "wmic", "cpu", "get", "ProcessorId" });
    	      localProcess.getOutputStream().close();
    	      Scanner localScanner = new Scanner(localProcess.getInputStream());
    	      localScanner.next();
    	      str = localScanner.next();
    	    }
    	    catch (IOException localIOException)
    	    {
    	      localIOException.printStackTrace();
    	    }
    	    return str;
	  }
	private static String toHexString(byte b) {
		int intValue = 0;
		if (b >= 0) {
			intValue = b;
		} else {
			intValue = 256 + b;
		}
		return Integer.toHexString(intValue);
	}
	  private static String getDefault(){
	      ByteArrayOutputStream out = new ByteArrayOutputStream();
	      System.getProperties().list(new PrintStream(out));
	      return out.toString();
	  }
	  private static String m()
	  {
	    String str = System.getProperty("os.name", "");
	    if ((str == null) || (str.length() == 0))
	      str = (String)System.getProperties().get("os.name");
	    str = str.toUpperCase();
	    if (str.indexOf("WINDOWS") >= 0)
	      return s();
	    if (str.indexOf("LINUX") >= 0)
	      return s();
	    return "";
	  }
	 
      public static void main(String[] args) {
		  System.out.println(s()+"机器码："+m());
  	}
}