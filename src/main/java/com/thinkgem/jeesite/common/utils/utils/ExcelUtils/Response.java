package com.thinkgem.jeesite.common.utils.utils.ExcelUtils;

import com.thinkgem.jeesite.common.utils.utils.excel.Excel;
import com.thinkgem.jeesite.common.utils.utils.excel.ExcelFactory;


import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;


/**
 * @description 提供基于HttpServletResponse的导出
 */
public class Response {
	
	/**
	 * 基于Java Web的导出excel,如果导出的字段是时间,则有两种思路：1.把字段类型设置为Date型 2.字段名称包含time,并且值为long型
	 * @param response	HttpServletResponse
	 * @param fileName 导出excel文件的名称,不带后缀名
	 * @param type     
	 * 		1 -- 导出大数据量的excel表格,不带任何样式(超过20w条左右的数据)
	 * 		2 -- 导出小量数据的excel表格,带有基本样式(20w左右以下的数据)
	 * @param titles  导出的excel表格的每一列的标题,选填
	 * @param datas   需要导出的数据项,必填
	 * @param keys    根据key到datas中获取数据,选填,如果没有填,则导出所有的数据记录
	 */
	public static <T> void exportExcel(HttpServletResponse response, String fileName, int type, String[] titles, List<T> datas, Object[] keys) {
		try {
			response.setContentType("application/vnd.ms-excel"); // 告知类型为excel文件
			response.setCharacterEncoding("utf-8");
			response.setHeader("Content-disposition", "attachment;filename=" + 
				new String(fileName.getBytes("utf-8"), "ISO8859-1") + ".xlsx");
			OutputStream os = response.getOutputStream();
			Excel excel = ExcelFactory.createExcel(type, titles, datas, keys);
			excel.export(os);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
