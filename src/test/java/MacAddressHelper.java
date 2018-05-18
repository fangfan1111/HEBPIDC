
import org.apache.commons.lang.StringUtils;

import java.io.*;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Scanner;

public class MacAddressHelper
{
    public static final boolean IS_DEBUG = false;

    public static boolean isValidMac(long paramLong)
    {
        if (paramLong == Long.parseLong("123456789012")) {
            return true;
        }

        int i = 10;
        for (int j = 0; j < i; j++) {
            if (getMyMacAsLong(j) == paramLong) {
                return true;
            }
        }
        return false;
    }

    public static long getMyMacAsLong(int paramInt) {
        String str = getMyMac(paramInt);

        return getMyMacAsLong(str);
    }

    public static long getMyMacAsLong() {
        return getMyMacAsLong(0);
    }

    public static long getMyMacAsLong(String paramString) {
        if ((paramString == null) || (paramString.length() <= 0)) {
            return 0L;
        }
        String str = paramString;

        str = replaceStr(str, "-", "");
        long l = Long.parseLong(str, 16);

        str = "" + l;
        if (str.length() > 12) {
            str = str.substring(0, 12);
            while ((str.charAt(0) == '0') && (str.length() > 0)) {
                str = str.substring(1, str.length());
            }
            l = Long.parseLong(str);
        }

        return l;
    }

    private static String getMacOnWindow(int paramInt) {
        String str1 = "";
        try {
            String str2 = "ipconfig /all";
            Process localProcess = Runtime.getRuntime().exec(str2);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream(),"UTF-8"));

            String localObject = localBufferedReader.readLine();
            int i = 0;
            while (localObject != null) {
                String str3 = localBufferedReader.readLine();

                if ((((String)localObject).indexOf("Physical Address") != -1))
                {
                    if (i == paramInt)
                    {
                        str1 = localObject.split(":")[1].trim();
                        break;
                    }
                    i++;
                }
                localObject = str3;
            }
            localBufferedReader.close();

            localProcess.waitFor();
        } catch (Exception localException) {
            str1 = "";
        }
        return str1.trim();
    }

    private static String getMacOnLinux(int paramInt) {
        String str1 = "";
        try {
            String str2 = "/sbin/ifconfig -a";
            Process localProcess = Runtime.getRuntime().exec(str2);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));

            String str3 = localBufferedReader.readLine().toUpperCase();
            int i = 0;
            while (str3 != null) {
                String str4 = localBufferedReader.readLine();
                if (str3.indexOf("HWADDR") > 0) {
                    if (i == paramInt) {
                        int j = str3.indexOf("HWADDR") + 7;
                        str1 = str3.substring(j);
                        break;
                    }
                    i++;
                }
                str3 = str4.toUpperCase();
            }
            localBufferedReader.close();

            localProcess.waitFor();
        } catch (Exception localException) {
            str1 = "";
        }
        return str1.trim().replace(':', '-');
    }

    private static String getMacOnHP(int paramInt) {
        String str1 = "";
        try {
            String str2 = "/usr/sbin/lanscan";
            Process localProcess = Runtime.getRuntime().exec(str2);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));

            String str3 = localBufferedReader.readLine().toUpperCase();
            int i = 0;
            while (str3 != null) {
                String str4 = localBufferedReader.readLine();
                int j = str3.indexOf("0X");
                if (j > 0) {
                    if (i == paramInt) {
                        int k = j + 2;
                        int m = str3.indexOf(" ", k);
                        str1 = str3.substring(k, m);
                        break;
                    }

                    i++;
                }
                str3 = str4.toUpperCase();
            }

            localBufferedReader.close();

            localProcess.waitFor();
        } catch (Exception localException) {
            str1 = "";
        }
        return str1.trim();
    }

    private static String getMacOnSolaris(int paramInt) {
        String str1 = "";
        Process localProcess = null;
        try {
            String str2 = "/usr/sbin/ifconfig -a";
            localProcess = Runtime.getRuntime().exec(str2);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));

            Object localObject1 = localBufferedReader.readLine().toUpperCase();
            int i = 0;
            while (localObject1 != null) {
                String str3 = localBufferedReader.readLine().toUpperCase();
                if (((String)localObject1).indexOf("NEI0") > 0) {
                    int j = str3.indexOf("INET") + 5;
                    if (j < 5)
                        break;
                    int k = str3.indexOf(" ", j);
                    if (k <= j)
                        break;
                    if (i == paramInt) {
                        str1 = str3.substring(j, k);
                        break;
                    }
                    i++;
                }
                localObject1 = str3;
            }
            localBufferedReader.close();

            localProcess.waitFor();
        }
        catch (Exception localException)
        {
        }
        finally
        {
            if (localProcess != null) {
                localProcess.destroy();
            }
        }
        if ((str1 == null) || (str1.length() <= 8)) {
            str1 = getMacOnSolaris2(paramInt);
        }

        if ((str1 == null) || (str1.length() < 8)) {
            return getMacOnSolaris3();
        }

        return replaceStr(str1, ".", "");
    }

    private static String getMacOnSolaris3()
    {
        String str1 = "";
        Process localProcess = null;
        try {
            localProcess = Runtime.getRuntime().exec("netstat -pn");
            InputStream localInputStream1 = localProcess.getInputStream();
            InputStream localInputStream2 = localProcess.getErrorStream();
            final ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
            Thread local1 = new Thread() { private InputStream inputStream;
                private  ByteArrayOutputStream byteArrayOutputStream;

                public void run() { try { int i = 0;
                    while ((i = this.inputStream.read()) != -1)
                        localByteArrayOutputStream.write(i);
                }
                catch (Exception localException)
                {
                }
                }
            };
            local1.start();

            int i = 0;
            while ((i = localInputStream1.read()) != -1) {
                localByteArrayOutputStream.write(i);
            }

            local1.join();
            str1 = new String(localByteArrayOutputStream.toByteArray());

            int j = str1.indexOf("SP");
            if (j != -1) {
                str1 = str1.substring(j + 2);
                while (str1.startsWith(" ")) {
                    str1 = str1.substring(1);
                }
                str1 = str1.substring(0, 17);
                return str1.replaceAll(":", "");
            }
        } catch (Exception localException) {
        }
        finally {
            if (localProcess != null) {
                localProcess.destroy();
            }
        }

        return str1;
    }

    private static String getMacOnSolaris2(int paramInt) {
        String str1 = "";
        try {
            String str2 = "/usr/sbin/ifconfig -a";
            Process localProcess = Runtime.getRuntime().exec(str2);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));

            String str3 = localBufferedReader.readLine().toUpperCase();
            int i = 0;
            while (str3 != null) {
                str3 = str3.toUpperCase();
                int j = str3.indexOf("ETHER");
                if (j >= 0) {
                    if (i == paramInt) {
                        j += 6;
                        int k = str3.indexOf(" ", j);
                        if (k <= 0)
                            k = str3.length();
                        str1 = str3.substring(j, k).trim();
                        break;
                    }
                    i++;
                }
                str3 = localBufferedReader.readLine();
            }
            localBufferedReader.close();
            localProcess.waitFor();
        } catch (Exception localException) {
            System.out.println( "获取Sun Solaris操作系统的Mac地址失败！(getMacOnSolaris2)");

            localException.printStackTrace();
        }
        str1 = replaceStr(str1, ".", "");
        str1 = replaceStr(str1, ":", "");
        return str1;
    }

    private static String getMacOnAIX(int paramInt) {
        Object localObject = "";
        try {
            String str1 = "/usr/bin/uname -m";
            Process localProcess = Runtime.getRuntime().exec(str1);
            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localProcess.getInputStream()));

            String str2 = localBufferedReader.readLine().toUpperCase();
            localObject = str2;
            localBufferedReader.close();

            localProcess.waitFor();
        } catch (Exception localException) {
            localObject = "";
        }
        return ((String)localObject).trim();
    }

    public static String getMyMac(int paramInt)
    {
        String str = System.getProperty("os.name", "");
        if (StringUtils.isEmpty(str)) {
            str = (String)System.getProperties().get("os.name");
        }
        if (StringUtils.isEmpty(str)) {
            System.out.println("Can't obatain the os name at runtime!");
            System.out.println("So can't mark the machine.");
            return "";
        }
        str = str.toUpperCase();

        if (str.indexOf("WINDOWS") >= 0)
            return getMacOnWindow(paramInt);
        if (str.indexOf("HP") >= 0)
            return getMacOnHP(paramInt);
        if (str.indexOf("LINUX") >= 0)
            return getMacOnLinux(paramInt);
        if ((str.indexOf("SOLARIS") >= 0) || (str.indexOf("SUNOS") >= 0))
            return getMacOnSolaris(paramInt);
        if (str.indexOf("AIX") >= 0)
            return getMacOnAIX(paramInt);
        if (str.indexOf("FREEBSD") != -1) {
            return getMacOnFreeBSD(paramInt);
        }
        return "";
    }

    private static String getMacOnFreeBSD(int paramInt)
    {
        InputStream localInputStream = null;
        InputStreamReader localInputStreamReader = null;
        BufferedReader localBufferedReader = null;
        String str1 = "";
        try {
            String str2 = "/sbin/ifconfig -a";
            Process localProcess = Runtime.getRuntime().exec(str2);
            localInputStream = localProcess.getInputStream();
            localInputStreamReader = new InputStreamReader(localInputStream);
            localBufferedReader = new BufferedReader(localInputStreamReader);
            String str3 = localBufferedReader.readLine();
            int i = 0;
            while (str3 != null) {
                str3 = str3.toUpperCase();
                if (str3.indexOf("ETHER") != -1) {
                    if (i == paramInt) {
                        str1 = str3.trim().split(" ")[1];
                        break;
                    }
                    i++;
                }
                str3 = localBufferedReader.readLine();
            }

            localProcess.waitFor();
        } catch (Exception localException1) {
        }
        finally {
            if (localInputStream != null)
                try {
                    localInputStream.close();
                }
                catch (Exception localException2) {
                }
            if (localInputStreamReader != null)
                try {
                    localInputStreamReader.close();
                }
                catch (Exception localException3) {
                }
            if (localBufferedReader != null)
                try {
                    localBufferedReader.close();
                }
                catch (Exception localException4)
                {
                }
        }
        return str1.trim().replace(':', '-');
    }
    public static String replaceStr(String paramString1, String paramString2, String paramString3)
    {
        if ((paramString1 == null) || (paramString3 == null) || (paramString2 == null)) {
            return paramString1;
        }

        char[] arrayOfChar1 = paramString1.toCharArray();
        int i = arrayOfChar1.length;
        if (i == 0) {
            return "";
        }

        char[] arrayOfChar2 = paramString2.toCharArray();
        int j = arrayOfChar2.length;
        if ((j == 0) || (j > i)) {
            return paramString1;
        }
        StringBuffer localStringBuffer = new StringBuffer(i * (1 + paramString3.length() / j));

        int i1 = 0;

        int k = 0;
        while (k < i) {
            i1 = 0;

            if (arrayOfChar1[k] == arrayOfChar2[0]) {
                int m = 0;
                for (m = 1; (m < j) &&
                        (k + m < i); m++)
                {
                    if (arrayOfChar1[(k + m)] != arrayOfChar2[m])
                        break;
                }
                i1 = m == j ? 1 : 0;
            }

            if (i1 != 0) {
                localStringBuffer.append(paramString3);
                k += j;
            }
            else
            {
                int n;
                if (k + j >= i)
                    n = i - 1;
                else {
                    n = k;
                }
                for (; k <= n; k++) {
                    localStringBuffer.append(arrayOfChar1[k]);
                }
            }
        }
        arrayOfChar1 = null;
        arrayOfChar2 = null;
        return localStringBuffer.toString();
    }
    private static String a(byte b) {
        int intValue = 0;
        if (b >= 0) {
            intValue = b;
        } else {
            intValue = 256 + b;
        }
        return Integer.toHexString(intValue);
    }
    public static void main(String[] paramArrayOfString) {
        /*long start = System.currentTimeMillis();
        Process process = null;
        try {
            process = Runtime.getRuntime().exec(
                    new String[] { "wmic", "cpu", "get", "ProcessorId" });
            process.getOutputStream().close();
            Scanner sc = new Scanner(process.getInputStream());
            while(sc.hasNext()){
                String property = sc.next();
                String serial = sc.next();
                System.out.println(property + ": " + serial);
                System.out.println("time:" + (System.currentTimeMillis() - start));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }*/
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
                            sb.append(a(addres[0])).append(
                                    a(addres[1])).append(
                                    a(addres[2])).append(
                                    a(addres[3])).append(
                                    a(addres[4])).append(
                                    a(addres[5]));
                            if (!sb.toString().equals("000000"))
                                f.append(sb.toString());
                        }
                    }
                }
                else
                    System.out.println("获取地址发生异常");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        System.out.println(f.toString());

    }
}