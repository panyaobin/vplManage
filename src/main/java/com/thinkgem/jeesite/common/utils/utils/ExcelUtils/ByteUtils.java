package com.thinkgem.jeesite.common.utils.utils.ExcelUtils;

import java.io.UnsupportedEncodingException;

/**
 * @description 字节码工具类
 * @author haoran.shu
 * @date 2016年9月6日 下午12:48:03
 *
 */
public class ByteUtils {
	
	/**
	 * 获取文本的字节数量,一个英文为1个字节,一个中文为两个字节
	 * @param text
	 * @return
	 * @throws UnsupportedEncodingException 返回的是GBK编码格式下的字节数量
	 */
	public static int getByteLength(String text) throws UnsupportedEncodingException {
		return text.getBytes("gbk").length;
	}
}
