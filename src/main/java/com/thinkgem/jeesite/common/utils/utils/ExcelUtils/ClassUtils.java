package com.thinkgem.jeesite.common.utils.utils.ExcelUtils;

import java.lang.reflect.Field;

/**
 * @description Class操作工具类,一般通过反射操作
 * @author haoran.shu
 * @date 2016年9月5日 上午9:53:03
 *
 */
public class ClassUtils {
	
	/**
	 * 获取类中所有的字段名(包含私有字段)
	 * @param clazz Class
	 * @return 字段名称的集合
	 */
	public static Object[] getFieldsName(Class<?> clazz) {
		// 获取所有的字段,包括私有字段
		Field[] fields = clazz.getDeclaredFields();
		Object[] fieldNames = new Object[fields.length];
		for(int i = 0; i < fields.length; i++) {
			fieldNames[i] = fields[i].getName();
		}
		return fieldNames;
	}
}
