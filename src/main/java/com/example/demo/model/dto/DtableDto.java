package com.example.demo.model.dto;

import org.hibernate.validator.constraints.Range;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtableDto {
	@NotNull(message = "{dtableDto.dtableId.notNull}")
	@Range(min = 1, max = 9999, message = "{dtableDto.dtableId.range}")
	private Integer dtableId;
	
	@NotEmpty(message = "{dtableDto.dtableName.notEmpty}")
	@Size(min = 2, message = "{dtableDto.dtableName.size}")
	private String dtableName;
	
	@NotNull(message = "{dtableDto.dtableSize.notNull}")
	@Range(min = 1, max = 500, message = "{dtableDto.dtableSize.range}")
	private Integer dtableSize;
}