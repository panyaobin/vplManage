package com.thinkgem.jeesite.common.utils.utils.excel;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import java.beans.IntrospectionException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * @description 构建大数据量的Excel表格,构建的表格中,没有任何的配置属性,不带任何样式,
 * 构建的Excel表格的后缀名为.xlsx,这种是从Microsoft Office 07版后默认的Excel后缀名
 */
public class SXSSFExcel extends Excel {
	private Log log = LogFactory.getLog(getClass());
	private SXSSFWorkbook wb;
	
	/**
	 * 构建表格
	 * @param titles	表格每一列的标题,可选
	 * @param datas		需要构建表格的数据集,可以是List<Map>可以是List<T>
	 * @param keys		需要导出的数据集中的key,可选
	 */
	public <T> SXSSFExcel(String[] titles, List<T> datas, Object[] keys) {
		// 构建工作簿,缓存1条记录到内存中
		wb = new SXSSFWorkbook(1);
		wb.setCompressTempFiles(true); // 启用临时文件压缩
		Sheet sheet = wb.createSheet("sheet"); // 创建工作表
		sheet.setColumnWidth(0,3500);
		sheet.setColumnWidth(1,50000);
		try {
			int start = createTitleRow(sheet, titles, null); // 构建标题行
			createDataRow(wb, start, datas, keys, null); // 创建数据行
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException
				| IntrospectionException | UnsupportedEncodingException e) {
			log.error("SXSSFExcel", e);
		}
	}
	
	/**
	 * 输出Excel表格
	 * @param os	输出流
	 * @throws IOException
	 */
	@Override
	public void export(OutputStream os) throws IOException {
		export(wb, os);
		wb.dispose(); // 情况临时文件
		wb = null;
	}
}
