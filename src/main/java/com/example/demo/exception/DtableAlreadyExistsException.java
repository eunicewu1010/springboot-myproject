package com.example.demo.exception;

import com.example.demo.model.entity.Dtable;

public class DtableAlreadyExistsException extends DtableException {

	public DtableAlreadyExistsException(String message) {
		super(message);
	}

}