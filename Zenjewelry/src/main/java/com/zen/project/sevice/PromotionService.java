package com.zen.project.sevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zen.project.dao.IPromotionDao;

@Service
public class PromotionService {

	@Autowired
	IPromotionDao pdao;
}
