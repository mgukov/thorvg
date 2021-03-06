

macro(print_compiled_files NAME FILES)
	message("Module '${NAME}' compiled files:")
	message("================================")
	foreach(file IN ITEMS ${FILES})
	    message("${file}")
	endforeach(file)
	message("================================")
endmacro()

function(set_compiled_files SRC_DIR INCLUDED_FILES)
	file(GLOB allFiles "${SRC_DIR}/*.cpp" "${SRC_DIR}/*.cc")
#	LIST(FILTER allFiles EXCLUDE REGEX ".*cmake-build-debug.*")
	set(${INCLUDED_FILES} ${allFiles} PARENT_SCOPE)
endfunction()