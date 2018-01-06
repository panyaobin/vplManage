package com.thinkgem.jeesite.common.utils.utils.excel;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.beans.IntrospectionException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description 构建带有基本样式的表格,后缀名为.xlsx
 * 		标题栏：字体加粗,并且列宽根据标题栏来动态更改宽度
 * 		数据项：自动换行
 * @author haoran.shu
 * @date 2016年9月6日 上午10:16:37
 *
 */
public class XSSF1Excel extends Excel {
	private Log log = LogFactory.getLog(getClass());
	private XSSFWorkbook wb;

	/**
	 *
	 * @param titles  标题栏,可选
	 * @param datas	   数据项,必填
	 * @param keys	   根据key到数据项中获取数据,必选
	 */
	public <T> XSSF1Excel(String[] titles, List<T> datas, Object[] keys) {
		wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("sheet");
		// 构建样式集
		Map<String, CellStyle> styles = generateStyles(wb);
		try {
			int start = createTitleRow(sheet, titles, styles.get("title")); // 创建标题栏
				sheet.setColumnWidth(0,3000);
				sheet.setColumnWidth(1,30000);
			createDataRow(wb, start, datas, keys, styles.get("item")); // 构建数据项
		} catch (UnsupportedEncodingException | IllegalAccessException | 
			IllegalArgumentException | InvocationTargetException | 
			IntrospectionException e) {
			log.error("XSSFExcel", e);
		}
	}
	
	private Map<String, CellStyle> generateStyles(XSSFWorkbook wb) {
		Map<String, CellStyle> styles = new HashMap<>();
		// 标题栏样式
		CellStyle titleStyle = wb.createCellStyle();
		XSSFFont font = wb.createFont();
		font.setFontHeightInPoints((short)11); // 设置字体大小
		font.setBold(true); // 字体加粗
		titleStyle.setFont(font);
		titleStyle.setAlignment(CellStyle.ALIGN_CENTER); // 设置水平居中
		titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); // 垂直居中
		styles.put("title", titleStyle);
		/* 数据项样式 */
		CellStyle itemStyle = wb.createCellStyle();
		itemStyle.setWrapText(true); // 自动换行
		itemStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER); // 水平居中
		itemStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); // 垂直居中
		styles.put("item", itemStyle);
		return styles;
	}


	@Override
	public void export(OutputStream os) throws IOException {
		export(wb, os);
		wb = null;
	}

}
