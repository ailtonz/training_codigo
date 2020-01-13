[boot loader]
timeout=1
default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
[operating systems]
multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Curso - WINDOWS - Drive C" /fastdetect
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Curso - WINDOWS - Drive D" /fastdetect
multi(0)disk(0)rdisk(0)partition(3)\WINDOWS="Curso - WINDOWS - Drive E" /fastdetect

multi(0)disk(0)rdisk(0)partition(1)\WINNT="Curso - WINNT - Drive C" /fastdetect
multi(0)disk(0)rdisk(0)partition(2)\WINNT="Curso - WINNT - Drive D" /fastdetect
multi(0)disk(0)rdisk(0)partition(3)\WINNT="Curso - WINNT - Drive E" /fastdetect



