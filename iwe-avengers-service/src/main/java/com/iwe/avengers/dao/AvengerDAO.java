package com.iwe.avengers.dao;

import java.util.HashMap;
import java.util.Map;

import com.iwe.avenger.dynamodb.entity.Avenger;

public class AvengerDAO {

	private Map<String, Avenger> mapper; 
	
	
	public AvengerDAO() {
		mapper = new HashMap<String, Avenger>();
		mapper.put("aaaa-bbbb-cccc-dddd", new Avenger("aaaa-bbbb-cccc-dddd", "Capitain America", "Steve Rogers"));
		mapper.put("aaaa-bbbb-cccc-eeee", new Avenger("aaaa-bbbb-cccc-eeee", "Black Widow", "Natasha Romanov"));
		mapper.put("aaaa-bbbb-cccc-ffff", new Avenger("aaaa-bbbb-cccc-ffff", "Iron Man", "Tony Stark"));
		mapper.put("aaaa-bbbb-cccc-gggg", new Avenger("aaaa-bbbb-cccc-gggg", "Hulk", "Bruce Banner"));
		
	}
	
	public Avenger search(String id) {
		return mapper.get(id);
	}

	public Avenger update(Avenger avenger) {
		// TODO Auto-generated method stub
		return mapper.replace(avenger.getId(), avenger);
	}

}
