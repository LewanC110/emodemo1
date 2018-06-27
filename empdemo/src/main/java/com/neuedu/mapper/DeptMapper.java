package com.neuedu.mapper;

import com.neuedu.entity.Dept;
import com.neuedu.entity.Emp;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptMapper {

    /**
     * 查询所有dept
     * @return
     */
    List<Dept> listDept();

    int getCount();

    int saveDept(@Param("dept") Dept dept);
    /**
     * 根据id数组删除dept
     * @param ids
     * @return 影响行数
     */
    int deleteDeptById(int[] ids);

}
