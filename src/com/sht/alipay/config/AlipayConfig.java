package com.sht.alipay.config;

import java.io.FileWriter;
import java.io.IOException;

import com.sht.util.Static.CONFIG;
import com.sht.util.Util;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	private static String url = Util.getValue(CONFIG.FIELD_ALIPAY_CONFIG_URL).toString();
	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016081500253717";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCDZDxpjKF3g3Arm5KqDl5RW6Z3BVj5l46wz0muHaNa8QM01dUpVDxApjSvp9n69B25JeaHa8cx/R6SI4jyp2ithLcU7fBs5Cq1k3lbI4KrKhK2Z4m9gTpxbOWvM3gO2rVRFqmxjPEERKXck6ZyUUa3eb/tM0Xwtbwy2FZ03VcIgn/wR76M+DxubEz6pB+dimlch0FtgWRYnJG9l0DimsKznwEayEUiJi7kLloaUKCAQd5i/pZLywGjwj5jbBDw2MB/7iHueAUA6jUqqUh+vy/NL6854Dz6b/47MU94/YHU+ksXMAoOEs98djUTGuYMzBKdfWoKD2MI/THOEeazF8A1AgMBAAECggEAWDw5IbyyNltLOc24+YC6sDI3IRizPrIbvfsGhOocaJcPyyyKgL2z1MqI+SlkhlXnnA2quWiUlaphHEzGzAXGkzhb5q8/VTEIyXVm+uBnAOE5PctcQaoGAGPb/wM2betL9k+c18JJnM8o/28cSQrxzYbyb62OG29AGnkT3llB+FEELKAmnWUtAuciw0g+slP+lc/D/1W2VLGivDQ8VJxIhW5pamtil0jIvwPfrJ8fALbSchCVpZ0C6q3n2y2/OM1BrsHd7WBse/QcOVkXhmfXc/kWrDEzfIRjO4ECgJNG0WpXdBnVnc576W2efHz3vq2J/bC6/pwvKIE2Fp8RhrrOYQKBgQDuFYmo67iyawRv1XCnMX//qJiqXTj5JRt6fhqVFnXC9FopJ1+BfmcJuN+8kUnG7Ttai5aeS5sHqrFpdHlX2ZyByg32nS/q+XvzuqIXG5MXse8jMupaWXi9Yj8aZLsN+QdrQr7TC7Y9/0l3/erZhCQASdP+7ad6EtqeENnNNCf+HQKBgQCNR142N8NYAyMloAhoxwuQq5U8EO4jpzACSo/tWlSzg8gZUfeVD6sE5i1wRb1zZ4plkObB9NROvG7nEEq7zFSeu6ANoiHSlfXXrldCy0EvurD5iX6RkAuzWDP9GfMas8ET/d+E5bUzDg4CY3F8XMp6vdYNTvVCAXg/jH3S57wO+QKBgHoTyRY4Z+f0P74oLy9LjlpE1KLmUgROJpzUdETl01Q3ftODQNFhQuwVQ4Oo6694jOqMkJpyIff4aiesdVu6VSmntSkyyBMwAYKju+ElXnLT5c6imM/i+KoC6mBaLh+oBUnWW4pTgwqfD8jbBcSqoNsVAALDURCjAj3yXft+NtNxAoGAQWkkpoek6u/w6u+wVQqrQR0gKEJSb7FtmfH5t1QWWVMPZyG7NomdjdQgf5XahD8RJbs0C+MWFSpLUrIJV+/f0epezVEexchmnah7gFJo6PdQDwjoz+5YbH3O/EVyeA93upDVV0ufXHcKZ3KxTXoMyU1xeJHxHdFeYlXiv65JNMkCgYAVjR5EO5XggCPQ4OS72vKSpF+7obTB8he4U6Pn+kjDe9aaHhVdKF8NEJfAVeBKHv6CH9dRHcIxqDoizCVDxTVzTEAv7wP0JNAvZXzGFYtpkRs/KNYErgAG7PdkHHqYGRixBW2t1MZxTD6Rn0lyPvvMauSZUEqjeOm791dalaX8lA==";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsShDfOubngp9latQu2Rq0lRYIrDPR4IzDUJbDlKQ/+zXEfnABuz9eLwKDHNQWPYht5Os4VOuI8mZBGS8erjeVQzPM9ziZ+pYwvoQTOi4PI1m1b/CvSau/eQMVSrRY+ICQZzDjHJngRaKWiYigvy/s8V/3QxacKLuIBjyVdAterXaTcIgPlwUCRMXVPZ+I6Fb4LeMO3pG2gl3HUUgIoUZg7NZQBV2AcZoSVtc+OuA0tAZWwKfq7xIsNSYahA1F87WB3b2zId/bbcogdecmdmJSLFxhklGlPSJ2+3AuVWCW3/6V7/f7io9XSLhDIaukb3CBxKc1ZK8Y3GkHXXWrJGa9wIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = url+"/sht/users/addMoney.action";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
//	public static String return_url = url+"/sht/users/view/index.jsp";
	public static String return_url = "";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

