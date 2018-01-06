package com.thinkgem.jeesite.common.utils.utils.excel;

import com.thinkgem.jeesite.common.utils.utils.ExcelUtils.ByteUtils;
import com.thinkgem.jeesite.common.utils.utils.ExcelUtils.ClassUtils;
import org.apache.poi.ss.usermodel.*;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;
import java.util.Map;


public abstract class Excel {
	
	
	/**
	 * 创建标题行
	 * @param sheet
	 * @param titles
	 * @param cellStyle
	 * @return 创建成功返回1，失败返回0
	 * @throws UnsupportedEncodingException
	 */
	int createTitleRow(Sheet sheet, String[] titles, CellStyle cellStyle) throws UnsupportedEncodingException {
		if(titles != null && titles.length > 0) {
			Row row = sheet.createRow(0);
			if(cellStyle != null) {
				row.setHeightInPoints((short)20); // 设置高度
			}
			for(int titleCellNum = 0; titleCellNum < titles.length; titleCellNum++) {
				Cell cell = row.createCell(titleCellNum);
				String title = titles[titleCellNum];
				cell.setCellValue(title);
				if(cellStyle != null) {
					cell.setCellStyle(cellStyle); // 设置行样式
					int textLength = ByteUtils.getByteLength(title); // 字节数量
					if(textLength >= sheet.getDefaultColumnWidth()) {
						sheet.setColumnWidth(titleCellNum, (ByteUtils.getByteLength(title) + 5) * 256);
					}
				}
			}
			return 1;
		} else {
			return 0;
		}
	}
	
	/**
	 * 创建数据行
	 * @param <T>
	 * @param workbook  Workbook
	 * @param start  数据行的开始位置
	 * @param datas  构建的数据
	 * @throws IntrospectionException 
	 * @throws InvocationTargetException 
	 * @throws IllegalArgumentException 
	 * @throws IllegalAccessException 
	 */
	<T> void createDataRow(Workbook workbook, int start, List<T> datas, Object[] keys, CellStyle style) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, IntrospectionException {
		// 标记是否需要刷新key
		boolean isUpdateKey = (keys == null || keys.length == 0) ? true : false;
		Sheet sheet = workbook.getSheet("sheet");
		// CreationHelper 是一个辅助类,用于创建不同格式的数据处理
		CreationHelper createHelper = workbook.getCreationHelper();
		// 创建单元格样式
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(style == null ? false : true); // 设置是否自动换行
		cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy/m/d h:mm:ss"));
		for(int rownum = 0; rownum < datas.size(); rownum++) {
			Row row = sheet.createRow(rownum + start);
			T t = datas.get(rownum); // 获取一条数据记录
			// 获取数据集合第一条记录的所有的key的集合
			if(isUpdateKey) {
				if(t instanceof Map<?, ?>) {
					keys = ((Map<?, ?>)t).keySet().toArray();
				} else { // 实体类不需要每次获取,因为实体类的字段基本已经固定
					if(keys == null) {
						keys = ClassUtils.getFieldsName(t.getClass());
					}
				}
			}
			for(int cellnum = 0; cellnum < keys.length; cellnum++) {
				Cell cell = row.createCell(cellnum);
				Object value = getValue(t, keys[cellnum].toString());
				// 如果key中包含time,并且value为long型的,则转换格式输出
				if((keys[cellnum].toString().toLowerCase().contains("time")
					&& value instanceof Long)) { // 是日期格式
					cell.setCellValue(new Date((Long)value));
					cell.setCellStyle(cellStyle); // 设置单元格样式
				} else if(value instanceof Date) {
					cell.setCellValue((Date)value);
					cell.setCellStyle(cellStyle); // 设置单元格样式
				} else {
					if(style != null) {
						if(value instanceof Number) {
							cell.setCellValue(Double.parseDouble(value.toString()));
						} else if(value instanceof Boolean) {
							cell.setCellValue((Boolean)value);
						} else {
							if(value == null) {
								cell.setCellValue("");
							} else {
								cell.setCellValue(value.toString());
							}
						}
						cell.setCellStyle(style);
					} else {
						if(value == null) {
							cell.setCellValue("");
						} else {
							cell.setCellValue(value.toString());
						}
					}
				}
			}
		}
	}
	
	/**
	 * 根据key获取value
	 * @param t		数据实体,可以是实体类,可以是实体类
	 * @param key	key
	 * @return
	 * @throws IntrospectionException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 */
	<T> Object getValue(T t, String key) throws IntrospectionException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		if(t instanceof Map<?, ?>) {
			Map<?, ?> map = (Map<?, ?>) t;
			return map.get(key);
		} else {
			// 通过PropertyDescriptor去获取符合规范的Java Bean规范的类数据
			PropertyDescriptor pd = new PropertyDescriptor(key, t.getClass());
			Method method = pd.getReadMethod(); // 获取实体类的get方法
			return method.invoke(t);
		}
	}
	
	/**
	 * 输出Excel表格
	 * @param wb  Workbook Excel工作簿
	 * @param os  OutputStream 输出流
	 * @throws IOException 
	 */
	void export(Workbook wb, OutputStream os) throws IOException {
		wb.write(os);
		// 关闭流,释放资源
		os.close();
	}
	
	/**
	 * 子类必须实现的导出方法,供外部调用
	 * 注意：导出的时候，现在只支持导出.xlsx,所以文件后缀名必须为.xlsx
	 * @param os  OutputStream
	 * @throws IOException 
	 */
	abstract public void export(OutputStream os) throws IOException;
}
