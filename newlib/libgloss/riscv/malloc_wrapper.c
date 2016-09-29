#include <stdint.h>
#include <reent.h>

// Wrap malloc call to make rtl work
void __attribute__ ((noinline)) *_malloc_r(struct _reent *ptr, size_t req_size) {

  return _usf_malloc_r(ptr, req_size);

}

// Wrap free call to make rtl work
void __attribute__ ((noinline)) _free_r(struct _reent *ptr,void *chunk) {

  _usf_free_r(ptr, chunk);
}
