package com.joven.base.mapper;

import com.joven.base.entity.DailyExpensesInfoEntity;

import java.util.List;


public interface DailyExpensesInfoMapper {

    List<DailyExpensesInfoEntity> getAllInfos(int beginNum, int pageSizeNum);

    DailyExpensesInfoEntity getInfoById(String id);

    List<DailyExpensesInfoEntity> getInfoByIds(List<String> ids);

    Boolean modifyInfoById(DailyExpensesInfoEntity dailyExpensesInfo);

    Boolean bathModifyInfoById(List<DailyExpensesInfoEntity> lists);

    void bathInsertInfos(List<DailyExpensesInfoEntity> lists);

    void deleteInfoByIds(List<String> ids);
}