package com.neuedu.service;

import com.neuedu.entity.Emp;

import java.util.List;

public interface EmpService {

    /**
     * 查询所有emp
     * @return
     */
    List<Emp> listEmp();

    /**
     * 根据id查询emp
     * @return
     */
    Emp getEmpById(int id);


    /**
     *  根据id的数组来删除多个emp
     * @param ids
     * @return 最后一页的页码
     */
    int deleteEmpByIds(int[] ids);



    /**
     * 添加emp
     * @param emp
     * @return
     */
    int saveEmp(Emp emp);

    /**
     * 修改emp
     *
     * @return
     */
    int updateEmp(Emp emp);
}
