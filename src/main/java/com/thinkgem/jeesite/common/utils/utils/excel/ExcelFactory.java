package com.thinkgem.jeesite.common.utils.utils.excel;

import java.util.List;

/**
 * 
 * @description： 工厂类用于根据不同的需求构建不同类型的Excel
 *
 */
public class ExcelFactory {
	
	/**
	 * 创建Excel类,会自动识别时间类型,如果key的名称中包含time字符,并且value是Long型的则转换据为时间类型
	 * @param type    
	 * 		type == 1,构建基于大数据量的Excel,不带任何的格式
	 * @param titles  标题,用于构建表格标题栏,可选
	 * @param datas  
	 * 	需要导出的数据,必填
	 * 		如果是List<HashMap>格式的数据,最好配置keys参数,根据配置的keys参数进行解析,因为HashMap的数据访问顺序是随机顺序
	 * 		如果是List<LinkedHashMap>,则keys参数为可选,如果配置了keys参数则根据keys进行解析,否则解析Map集合中的所有的数据\
	 * 		如果是List<T>,T代表实体类对象,这个时候key表示实体类中的字段名,如果没有传递key则会把实体类的所有字段数据都导出来
	 * @param keys  根据key去进行解析,可选
	 * @return	根据type创建的不同的Excel类
	 */
	public static <T> Excel createExcel(int type, String[] titles, List<T> datas, Object[] keys) {
		if(type == 1) {
			return new SXSSFExcel(titles, datas, keys);
		} else if(type == 2) {
			return new XSSFExcel(titles, datas, keys);
		} else if(type == 2_1) {
			return new XSSF1Excel(titles, datas, keys);
		} else {
			return new XSSFExcel(titles, datas, keys);
		}
	}
	
}
