; ModuleID = 'C:/XinlinxHLS/tutor3/solution5/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.sideeffect() #0

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define void @apatb_matrix_mult_ir([5 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %a, [5 x i8]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %b, [5 x i16]* noalias nocapture nonnull "fpga.decayed.dim.hint"="5" %prod) local_unnamed_addr #1 {
entry:
  %a_copy1 = alloca [5 x i40], align 512
  %b_copy2 = alloca [5 x i40], align 512
  %prod_copy = alloca [5 x [5 x i16]], align 512
  %0 = bitcast [5 x i8]* %a to [5 x [5 x i8]]*
  %1 = bitcast [5 x i8]* %b to [5 x [5 x i8]]*
  %2 = bitcast [5 x i16]* %prod to [5 x [5 x i16]]*
  call void @copy_in([5 x [5 x i8]]* nonnull %0, [5 x i40]* nonnull align 512 %a_copy1, [5 x [5 x i8]]* nonnull %1, [5 x i40]* nonnull align 512 %b_copy2, [5 x [5 x i16]]* nonnull %2, [5 x [5 x i16]]* nonnull align 512 %prod_copy)
  %3 = getelementptr [5 x i40], [5 x i40]* %a_copy1, i64 0, i64 0
  call void @llvm.sideeffect() #7 [ "xlx_array_reshape"(i40* %3, i32 998, i32 1, i32 0) ], !dbg !5
  call void @llvm.sideeffect() #7 [ "xlx_array_reshape"([5 x i40]* %b_copy2, i32 998, i32 1, i32 0) ], !dbg !374
  call void @apatb_matrix_mult_hw([5 x i40]* %a_copy1, [5 x i40]* %b_copy2, [5 x [5 x i16]]* %prod_copy)
  call void @copy_back([5 x [5 x i8]]* %0, [5 x i40]* %a_copy1, [5 x [5 x i8]]* %1, [5 x i40]* %b_copy2, [5 x [5 x i16]]* %2, [5 x [5 x i16]]* %prod_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8([5 x i8]* %dst.addr, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8([5 x i8]* "orig.arg.no"="0" %dst, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i8, i8* %src.addr, align 1
  store i8 %3, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* noalias align 512 %dst, [5 x [5 x i16]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [5 x i16]]* %dst, null
  %1 = icmp eq [5 x [5 x i16]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i16([5 x [5 x i16]]* nonnull %dst, [5 x [5 x i16]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i16([5 x [5 x i16]]* %dst, [5 x [5 x i16]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [5 x i16]]* %src, null
  %1 = icmp eq [5 x [5 x i16]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i16]], [5 x [5 x i16]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i16]], [5 x [5 x i16]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i16([5 x i16]* %dst.addr, [5 x i16]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i16([5 x i16]* %dst, [5 x i16]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x i16]* %src, null
  %1 = icmp eq [5 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i16], [5 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i16], [5 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.5.6(i40* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq i40* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %dst_shift, %3
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %5 = load i8, i8* %src.addr, align 1
  %6 = load i40, i40* %dst, align 8
  %7 = trunc i64 %4 to i40
  %8 = shl i40 255, %7
  %9 = zext i8 %5 to i40
  %10 = shl i40 %9, %7
  %thr.xor1 = xor i40 %8, -1
  %thr.and2 = and i40 %6, %thr.xor1
  %thr.or3 = or i40 %thr.and2, %10
  store i40 %thr.or3, i40* %dst, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.4.7([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr1 = getelementptr [5 x i40], [5 x i40]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.5.6(i40* %dst.addr1, i64 %dst_shift, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.3.8([5 x i40]* noalias align 512 "orig.arg.no"="0" %dst, [5 x [5 x i8]]* noalias readonly "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x i40]* %dst, null
  %1 = icmp eq [5 x [5 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.4.7([5 x i40]* nonnull %dst, i64 0, [5 x [5 x i8]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.11.12([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x i8]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i8]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  %3 = trunc i64 %dst_shift to i40
  %4 = shl i40 255, %3
  %5 = xor i40 %4, -1
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr1 = getelementptr [5 x i40], [5 x i40]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x i8], [5 x i8]* %src, i64 0, i64 %for.loop.idx2
  %6 = load i8, i8* %src.addr, align 1
  %7 = load i40, i40* %dst.addr1, align 8
  %8 = zext i8 %6 to i40
  %9 = shl i40 %8, %3
  %10 = and i40 %7, %5
  %11 = or i40 %10, %9
  store i40 %11, i40* %dst.addr1, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.10.13([5 x i40]* "orig.arg.no"="0" %dst, i64 %dst_shift, [5 x [5 x i8]]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %src, null
  %1 = icmp eq [5 x i40]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %dst_shift, %3
  %src.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.11.12([5 x i40]* %dst, i64 %4, [5 x i8]* %src.addr, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.9.14([5 x i40]* noalias align 512 "orig.arg.no"="0" %dst, [5 x [5 x i8]]* noalias readonly "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x i40]* %dst, null
  %1 = icmp eq [5 x [5 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.10.13([5 x i40]* nonnull %dst, i64 0, [5 x [5 x i8]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([5 x [5 x i8]]* noalias readonly "orig.arg.no"="0", [5 x i40]* noalias align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias readonly "orig.arg.no"="2", [5 x i40]* noalias align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias readonly "orig.arg.no"="4", [5 x [5 x i16]]* noalias align 512 "orig.arg.no"="5") #4 {
entry:
  call void @onebyonecpy_hls.p0a5a5i8.3.8([5 x i40]* align 512 %1, [5 x [5 x i8]]* %0)
  call void @onebyonecpy_hls.p0a5a5i8.9.14([5 x i40]* align 512 %3, [5 x [5 x i8]]* %2)
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* align 512 %5, [5 x [5 x i16]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.21.22([5 x i8]* "orig.arg.no"="0" %dst, i40* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i40* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %src_shift, %3
  %5 = load i40, i40* %src, align 8
  %6 = trunc i64 %4 to i40
  %7 = lshr i40 %5, %6
  %8 = trunc i40 %7 to i8
  store i8 %8, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.20.23([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr1 = getelementptr [5 x i40], [5 x i40]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a5i8.21.22([5 x i8]* %dst.addr, i40* %src.addr1, i64 %src_shift, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.19.24([5 x [5 x i8]]* noalias "orig.arg.no"="0" %dst, [5 x i40]* noalias readonly align 512 "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %dst, null
  %1 = icmp eq [5 x i40]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.20.23([5 x [5 x i8]]* nonnull %dst, [5 x i40]* nonnull %src, i64 0, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5i8.27.28([5 x i8]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  %3 = trunc i64 %src_shift to i40
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x i8], [5 x i8]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr1 = getelementptr [5 x i40], [5 x i40]* %src, i64 0, i64 %for.loop.idx2
  %4 = load i40, i40* %src.addr1, align 8
  %5 = lshr i40 %4, %3
  %6 = trunc i40 %5 to i8
  store i8 %6, i8* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a5i8.26.29([5 x [5 x i8]]* "orig.arg.no"="0" %dst, [5 x i40]* readonly "orig.arg.no"="1" %src, i64 %src_shift, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [5 x i40]* %src, null
  %1 = icmp eq [5 x [5 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [5 x i8]], [5 x [5 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 8, %for.loop.idx2
  %4 = add i64 %src_shift, %3
  call void @arraycpy_hls.p0a5i8.27.28([5 x i8]* %dst.addr, [5 x i40]* %src, i64 %4, i64 5)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a5a5i8.25.30([5 x [5 x i8]]* noalias "orig.arg.no"="0" %dst, [5 x i40]* noalias readonly align 512 "orig.arg.no"="1" %src) #3 {
entry:
  %0 = icmp eq [5 x [5 x i8]]* %dst, null
  %1 = icmp eq [5 x i40]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a5i8.26.29([5 x [5 x i8]]* nonnull %dst, [5 x i40]* nonnull %src, i64 0, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([5 x [5 x i8]]* noalias "orig.arg.no"="0", [5 x i40]* noalias readonly align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias "orig.arg.no"="2", [5 x i40]* noalias readonly align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias "orig.arg.no"="4", [5 x [5 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call void @onebyonecpy_hls.p0a5a5i8.19.24([5 x [5 x i8]]* %0, [5 x i40]* align 512 %1)
  call void @onebyonecpy_hls.p0a5a5i8.25.30([5 x [5 x i8]]* %2, [5 x i40]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* %4, [5 x [5 x i16]]* align 512 %5)
  ret void
}

declare void @apatb_matrix_mult_hw([5 x i40]*, [5 x i40]*, [5 x [5 x i16]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([5 x [5 x i8]]* noalias "orig.arg.no"="0", [5 x i40]* noalias readonly align 512 "orig.arg.no"="1", [5 x [5 x i8]]* noalias "orig.arg.no"="2", [5 x i40]* noalias readonly align 512 "orig.arg.no"="3", [5 x [5 x i16]]* noalias "orig.arg.no"="4", [5 x [5 x i16]]* noalias readonly align 512 "orig.arg.no"="5") #5 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a5i16([5 x [5 x i16]]* %4, [5 x [5 x i16]]* align 512 %5)
  ret void
}

define void @matrix_mult_hw_stub_wrapper([5 x i40]*, [5 x i40]*, [5 x [5 x i16]]*) #6 {
entry:
  %3 = alloca [5 x [5 x i8]]
  %4 = alloca [5 x [5 x i8]]
  call void @copy_out([5 x [5 x i8]]* %3, [5 x i40]* %0, [5 x [5 x i8]]* %4, [5 x i40]* %1, [5 x [5 x i16]]* null, [5 x [5 x i16]]* %2)
  %5 = bitcast [5 x [5 x i8]]* %3 to [5 x i8]*
  %6 = bitcast [5 x [5 x i8]]* %4 to [5 x i8]*
  %7 = bitcast [5 x [5 x i16]]* %2 to [5 x i16]*
  call void @matrix_mult_hw_stub([5 x i8]* %5, [5 x i8]* %6, [5 x i16]* %7)
  call void @copy_in([5 x [5 x i8]]* %3, [5 x i40]* %0, [5 x [5 x i8]]* %4, [5 x i40]* %1, [5 x [5 x i16]]* null, [5 x [5 x i16]]* %2)
  ret void
}

declare void @matrix_mult_hw_stub([5 x i8]* noalias nocapture nonnull readonly, [5 x i8]* noalias nocapture nonnull readonly, [5 x i16]* noalias nocapture nonnull)

attributes #0 = { inaccessiblememonly nounwind willreturn }
attributes #1 = { inaccessiblemem_or_argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #5 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #6 = { "fpga.wrapper.func"="stub" }
attributes #7 = { inaccessiblememonly nounwind willreturn "xlx.source"="infer-from-pragma" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !DILocation(line: 8, column: 9, scope: !6)
!6 = !DILexicalBlockFile(scope: !8, file: !7, discriminator: 0)
!7 = !DIFile(filename: "C:/XinlinxHLS/tutor3/solution5/directives.tcl", directory: "C:\5CXinlinxHLS")
!8 = distinct !DISubprogram(name: "matrix_mult", linkageName: "_Z11matrix_multPA5_cS0_PA5_s", scope: !9, file: !9, line: 4, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !26, variables: !4)
!9 = !DIFile(filename: "matrix_mult.cpp", directory: "C:\5CXinlinxHLS")
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !19, !22}
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 40, elements: !17)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_a", file: !15, line: 15, baseType: !16)
!15 = !DIFile(filename: "./matrix_mult.h", directory: "C:\5CXinlinxHLS")
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !{!18}
!18 = !DISubrange(count: 5)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 40, elements: !17)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_b", file: !15, line: 16, baseType: !16)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 80, elements: !17)
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "mat_prod", file: !15, line: 17, baseType: !25)
!25 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!26 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !27, producer: "clang version 7.0.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, imports: !28)
!27 = !DIFile(filename: "C:/XinlinxHLS/tutor3/solution5/.autopilot/db\5Cmatrix_mult.pp.0.cpp", directory: "C:\5CXinlinxHLS")
!28 = !{!29, !37, !43, !45, !47, !51, !53, !55, !57, !59, !61, !63, !65, !70, !74, !76, !78, !83, !85, !87, !89, !91, !93, !95, !97, !100, !102, !106, !111, !113, !115, !117, !119, !121, !123, !125, !127, !129, !131, !135, !139, !141, !143, !145, !147, !149, !151, !153, !155, !157, !159, !161, !163, !165, !167, !169, !173, !177, !181, !183, !185, !187, !189, !191, !193, !195, !197, !199, !203, !207, !211, !213, !215, !217, !222, !226, !230, !232, !234, !236, !238, !240, !242, !244, !246, !248, !250, !252, !254, !259, !263, !267, !269, !271, !273, !279, !283, !287, !289, !291, !293, !295, !297, !299, !303, !307, !309, !311, !313, !315, !319, !323, !327, !329, !331, !333, !335, !337, !339, !343, !347, !351, !353, !357, !361, !363, !365, !367, !369, !371, !373}
!29 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !31, file: !36, line: 52)
!30 = !DINamespace(name: "std", scope: null)
!31 = !DISubprogram(name: "abs", scope: !32, file: !32, line: 254, type: !33, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!32 = !DIFile(filename: "C:/XilinxVivado/Vitis_HLS/2024.1/tps/mingw/8.3.0/win64.o/nt\5Cx86_64-w64-mingw32\5Cinclude\5Cmath.h", directory: "C:\5CXinlinxHLS")
!33 = !DISubroutineType(types: !34)
!34 = !{!35, !35}
!35 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!36 = !DIFile(filename: "C:/XilinxVivado/Vitis_HLS/2024.1/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Cbits/std_abs.h", directory: "C:\5CXinlinxHLS")
!37 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !38, file: !42, line: 83)
!38 = !DISubprogram(name: "acos", scope: !32, file: !32, line: 190, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!39 = !DISubroutineType(types: !40)
!40 = !{!41, !41}
!41 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!42 = !DIFile(filename: "C:/XilinxVivado/Vitis_HLS/2024.1/tps/mingw/8.3.0/win64.o/nt\5Clib\5Cgcc\5Cx86_64-w64-mingw32\5C8.3.0\5Cinclude\5Cc++\5Ccmath", directory: "C:\5CXinlinxHLS")
!43 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !44, file: !42, line: 102)
!44 = !DISubprogram(name: "asin", scope: !32, file: !32, line: 189, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!45 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !46, file: !42, line: 121)
!46 = !DISubprogram(name: "atan", scope: !32, file: !32, line: 191, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!47 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !48, file: !42, line: 140)
!48 = !DISubprogram(name: "atan2", scope: !32, file: !32, line: 192, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!49 = !DISubroutineType(types: !50)
!50 = !{!41, !41, !41}
!51 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !52, file: !42, line: 161)
!52 = !DISubprogram(name: "ceil", scope: !32, file: !32, line: 198, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!53 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !54, file: !42, line: 180)
!54 = !DISubprogram(name: "cos", scope: !32, file: !32, line: 184, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!55 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !56, file: !42, line: 199)
!56 = !DISubprogram(name: "cosh", scope: !32, file: !32, line: 187, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!57 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !58, file: !42, line: 218)
!58 = !DISubprogram(name: "exp", scope: !32, file: !32, line: 193, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!59 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !60, file: !42, line: 237)
!60 = !DISubprogram(name: "fabs", scope: !32, file: !32, line: 204, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!61 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !62, file: !42, line: 256)
!62 = !DISubprogram(name: "floor", scope: !32, file: !32, line: 199, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!63 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !64, file: !42, line: 275)
!64 = !DISubprogram(name: "fmod", scope: !32, file: !32, line: 246, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!65 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !66, file: !42, line: 296)
!66 = !DISubprogram(name: "frexp", scope: !32, file: !32, line: 244, type: !67, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!67 = !DISubroutineType(types: !68)
!68 = !{!41, !41, !69}
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!70 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !71, file: !42, line: 315)
!71 = !DISubprogram(name: "ldexp", scope: !32, file: !32, line: 243, type: !72, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!72 = !DISubroutineType(types: !73)
!73 = !{!41, !41, !35}
!74 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !75, file: !42, line: 334)
!75 = !DISubprogram(name: "log", scope: !32, file: !32, line: 194, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!76 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !77, file: !42, line: 353)
!77 = !DISubprogram(name: "log10", scope: !32, file: !32, line: 195, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!78 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !79, file: !42, line: 372)
!79 = !DISubprogram(name: "modf", scope: !32, file: !32, line: 245, type: !80, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!80 = !DISubroutineType(types: !81)
!81 = !{!41, !41, !82}
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!83 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !84, file: !42, line: 384)
!84 = !DISubprogram(name: "pow", scope: !32, file: !32, line: 196, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!85 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !86, file: !42, line: 421)
!86 = !DISubprogram(name: "sin", scope: !32, file: !32, line: 183, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!87 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !88, file: !42, line: 440)
!88 = !DISubprogram(name: "sinh", scope: !32, file: !32, line: 186, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!89 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !90, file: !42, line: 459)
!90 = !DISubprogram(name: "sqrt", scope: !32, file: !32, line: 197, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!91 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !92, file: !42, line: 478)
!92 = !DISubprogram(name: "tan", scope: !32, file: !32, line: 185, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!93 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !94, file: !42, line: 497)
!94 = !DISubprogram(name: "tanh", scope: !32, file: !32, line: 188, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!95 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !96, file: !42, line: 1065)
!96 = !DIDerivedType(tag: DW_TAG_typedef, name: "double_t", file: !32, line: 373, baseType: !41)
!97 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !98, file: !42, line: 1066)
!98 = !DIDerivedType(tag: DW_TAG_typedef, name: "float_t", file: !32, line: 372, baseType: !99)
!99 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!100 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !101, file: !42, line: 1069)
!101 = !DISubprogram(name: "acosh", scope: !32, file: !32, line: 705, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !103, file: !42, line: 1070)
!103 = !DISubprogram(name: "acoshf", scope: !32, file: !32, line: 706, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!104 = !DISubroutineType(types: !105)
!105 = !{!99, !99}
!106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !107, file: !42, line: 1071)
!107 = !DISubprogram(name: "acoshl", scope: !32, file: !32, line: 707, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!108 = !DISubroutineType(types: !109)
!109 = !{!110, !110}
!110 = !DIBasicType(name: "long double", size: 64, encoding: DW_ATE_float)
!111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !112, file: !42, line: 1073)
!112 = !DISubprogram(name: "asinh", scope: !32, file: !32, line: 710, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!113 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !114, file: !42, line: 1074)
!114 = !DISubprogram(name: "asinhf", scope: !32, file: !32, line: 711, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !116, file: !42, line: 1075)
!116 = !DISubprogram(name: "asinhl", scope: !32, file: !32, line: 712, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !118, file: !42, line: 1077)
!118 = !DISubprogram(name: "atanh", scope: !32, file: !32, line: 715, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!119 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !120, file: !42, line: 1078)
!120 = !DISubprogram(name: "atanhf", scope: !32, file: !32, line: 716, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !122, file: !42, line: 1079)
!122 = !DISubprogram(name: "atanhl", scope: !32, file: !32, line: 717, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !124, file: !42, line: 1081)
!124 = !DISubprogram(name: "cbrt", scope: !32, file: !32, line: 877, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !126, file: !42, line: 1082)
!126 = !DISubprogram(name: "cbrtf", scope: !32, file: !32, line: 878, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !128, file: !42, line: 1083)
!128 = !DISubprogram(name: "cbrtl", scope: !32, file: !32, line: 879, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!129 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !130, file: !42, line: 1085)
!130 = !DISubprogram(name: "copysign", scope: !32, file: !32, line: 1063, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !132, file: !42, line: 1086)
!132 = !DISubprogram(name: "copysignf", scope: !32, file: !32, line: 1064, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!133 = !DISubroutineType(types: !134)
!134 = !{!99, !99, !99}
!135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !136, file: !42, line: 1087)
!136 = !DISubprogram(name: "copysignl", scope: !32, file: !32, line: 1065, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!137 = !DISubroutineType(types: !138)
!138 = !{!110, !110, !110}
!139 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !140, file: !42, line: 1089)
!140 = !DISubprogram(name: "erf", scope: !32, file: !32, line: 901, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !142, file: !42, line: 1090)
!142 = !DISubprogram(name: "erff", scope: !32, file: !32, line: 902, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!143 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !144, file: !42, line: 1091)
!144 = !DISubprogram(name: "erfl", scope: !32, file: !32, line: 903, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!145 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !146, file: !42, line: 1093)
!146 = !DISubprogram(name: "erfc", scope: !32, file: !32, line: 906, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!147 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !148, file: !42, line: 1094)
!148 = !DISubprogram(name: "erfcf", scope: !32, file: !32, line: 907, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!149 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !150, file: !42, line: 1095)
!150 = !DISubprogram(name: "erfcl", scope: !32, file: !32, line: 908, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !152, file: !42, line: 1097)
!152 = !DISubprogram(name: "exp2", scope: !32, file: !32, line: 728, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!153 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !154, file: !42, line: 1098)
!154 = !DISubprogram(name: "exp2f", scope: !32, file: !32, line: 729, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !156, file: !42, line: 1099)
!156 = !DISubprogram(name: "exp2l", scope: !32, file: !32, line: 730, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !158, file: !42, line: 1101)
!158 = !DISubprogram(name: "expm1", scope: !32, file: !32, line: 734, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !160, file: !42, line: 1102)
!160 = !DISubprogram(name: "expm1f", scope: !32, file: !32, line: 735, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !162, file: !42, line: 1103)
!162 = !DISubprogram(name: "expm1l", scope: !32, file: !32, line: 736, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!163 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !164, file: !42, line: 1105)
!164 = !DISubprogram(name: "fdim", scope: !32, file: !32, line: 1109, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!165 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !166, file: !42, line: 1106)
!166 = !DISubprogram(name: "fdimf", scope: !32, file: !32, line: 1110, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!167 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !168, file: !42, line: 1107)
!168 = !DISubprogram(name: "fdiml", scope: !32, file: !32, line: 1111, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !170, file: !42, line: 1109)
!170 = !DISubprogram(name: "fma", scope: !32, file: !32, line: 1130, type: !171, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!171 = !DISubroutineType(types: !172)
!172 = !{!41, !41, !41, !41}
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !174, file: !42, line: 1110)
!174 = !DISubprogram(name: "fmaf", scope: !32, file: !32, line: 1131, type: !175, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!175 = !DISubroutineType(types: !176)
!176 = !{!99, !99, !99, !99}
!177 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !178, file: !42, line: 1111)
!178 = !DISubprogram(name: "fmal", scope: !32, file: !32, line: 1132, type: !179, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!179 = !DISubroutineType(types: !180)
!180 = !{!110, !110, !110, !110}
!181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !182, file: !42, line: 1113)
!182 = !DISubprogram(name: "fmax", scope: !32, file: !32, line: 1119, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !184, file: !42, line: 1114)
!184 = !DISubprogram(name: "fmaxf", scope: !32, file: !32, line: 1120, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !186, file: !42, line: 1115)
!186 = !DISubprogram(name: "fmaxl", scope: !32, file: !32, line: 1121, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !188, file: !42, line: 1117)
!188 = !DISubprogram(name: "fmin", scope: !32, file: !32, line: 1124, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !190, file: !42, line: 1118)
!190 = !DISubprogram(name: "fminf", scope: !32, file: !32, line: 1125, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !192, file: !42, line: 1119)
!192 = !DISubprogram(name: "fminl", scope: !32, file: !32, line: 1126, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!193 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !194, file: !42, line: 1121)
!194 = !DISubprogram(name: "hypot", scope: !32, file: !32, line: 882, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !196, file: !42, line: 1122)
!196 = !DISubprogram(name: "hypotf", scope: !32, file: !32, line: 883, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!197 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !198, file: !42, line: 1123)
!198 = !DISubprogram(name: "hypotl", scope: !32, file: !32, line: 887, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !200, file: !42, line: 1125)
!200 = !DISubprogram(name: "ilogb", scope: !32, file: !32, line: 748, type: !201, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!201 = !DISubroutineType(types: !202)
!202 = !{!35, !41}
!203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !204, file: !42, line: 1126)
!204 = !DISubprogram(name: "ilogbf", scope: !32, file: !32, line: 749, type: !205, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!205 = !DISubroutineType(types: !206)
!206 = !{!35, !99}
!207 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !208, file: !42, line: 1127)
!208 = !DISubprogram(name: "ilogbl", scope: !32, file: !32, line: 750, type: !209, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!209 = !DISubroutineType(types: !210)
!210 = !{!35, !110}
!211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !212, file: !42, line: 1129)
!212 = !DISubprogram(name: "lgamma", scope: !32, file: !32, line: 911, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!213 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !214, file: !42, line: 1130)
!214 = !DISubprogram(name: "lgammaf", scope: !32, file: !32, line: 912, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !216, file: !42, line: 1131)
!216 = !DISubprogram(name: "lgammal", scope: !32, file: !32, line: 913, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !218, file: !42, line: 1134)
!218 = !DISubprogram(name: "llrint", scope: !32, file: !32, line: 946, type: !219, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!219 = !DISubroutineType(types: !220)
!220 = !{!221, !41}
!221 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !223, file: !42, line: 1135)
!223 = !DISubprogram(name: "llrintf", scope: !32, file: !32, line: 947, type: !224, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!224 = !DISubroutineType(types: !225)
!225 = !{!221, !99}
!226 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !227, file: !42, line: 1136)
!227 = !DISubprogram(name: "llrintl", scope: !32, file: !32, line: 948, type: !228, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!228 = !DISubroutineType(types: !229)
!229 = !{!221, !110}
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !231, file: !42, line: 1138)
!231 = !DISubprogram(name: "llround", scope: !32, file: !32, line: 1038, type: !219, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !233, file: !42, line: 1139)
!233 = !DISubprogram(name: "llroundf", scope: !32, file: !32, line: 1039, type: !224, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !235, file: !42, line: 1140)
!235 = !DISubprogram(name: "llroundl", scope: !32, file: !32, line: 1040, type: !228, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!236 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !237, file: !42, line: 1143)
!237 = !DISubprogram(name: "log1p", scope: !32, file: !32, line: 768, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !239, file: !42, line: 1144)
!239 = !DISubprogram(name: "log1pf", scope: !32, file: !32, line: 769, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !241, file: !42, line: 1145)
!241 = !DISubprogram(name: "log1pl", scope: !32, file: !32, line: 770, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !243, file: !42, line: 1147)
!243 = !DISubprogram(name: "log2", scope: !32, file: !32, line: 773, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !245, file: !42, line: 1148)
!245 = !DISubprogram(name: "log2f", scope: !32, file: !32, line: 774, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !247, file: !42, line: 1149)
!247 = !DISubprogram(name: "log2l", scope: !32, file: !32, line: 775, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !249, file: !42, line: 1151)
!249 = !DISubprogram(name: "logb", scope: !32, file: !32, line: 778, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !251, file: !42, line: 1152)
!251 = !DISubprogram(name: "logbf", scope: !32, file: !32, line: 779, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!252 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !253, file: !42, line: 1153)
!253 = !DISubprogram(name: "logbl", scope: !32, file: !32, line: 780, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !255, file: !42, line: 1155)
!255 = !DISubprogram(name: "lrint", scope: !32, file: !32, line: 942, type: !256, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!256 = !DISubroutineType(types: !257)
!257 = !{!258, !41}
!258 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !260, file: !42, line: 1156)
!260 = !DISubprogram(name: "lrintf", scope: !32, file: !32, line: 943, type: !261, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!261 = !DISubroutineType(types: !262)
!262 = !{!258, !99}
!263 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !264, file: !42, line: 1157)
!264 = !DISubprogram(name: "lrintl", scope: !32, file: !32, line: 944, type: !265, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!265 = !DISubroutineType(types: !266)
!266 = !{!258, !110}
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !268, file: !42, line: 1159)
!268 = !DISubprogram(name: "lround", scope: !32, file: !32, line: 1035, type: !256, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!269 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !270, file: !42, line: 1160)
!270 = !DISubprogram(name: "lroundf", scope: !32, file: !32, line: 1036, type: !261, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !272, file: !42, line: 1161)
!272 = !DISubprogram(name: "lroundl", scope: !32, file: !32, line: 1037, type: !265, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!273 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !274, file: !42, line: 1163)
!274 = !DISubprogram(name: "nan", scope: !32, file: !32, line: 1087, type: !275, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!275 = !DISubroutineType(types: !276)
!276 = !{!41, !277}
!277 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !278, size: 64)
!278 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !16)
!279 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !280, file: !42, line: 1164)
!280 = !DISubprogram(name: "nanf", scope: !32, file: !32, line: 1088, type: !281, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!281 = !DISubroutineType(types: !282)
!282 = !{!99, !277}
!283 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !284, file: !42, line: 1165)
!284 = !DISubprogram(name: "nanl", scope: !32, file: !32, line: 1089, type: !285, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!285 = !DISubroutineType(types: !286)
!286 = !{!110, !277}
!287 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !288, file: !42, line: 1167)
!288 = !DISubprogram(name: "nearbyint", scope: !32, file: !32, line: 931, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!289 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !290, file: !42, line: 1168)
!290 = !DISubprogram(name: "nearbyintf", scope: !32, file: !32, line: 932, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !292, file: !42, line: 1169)
!292 = !DISubprogram(name: "nearbyintl", scope: !32, file: !32, line: 933, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !294, file: !42, line: 1171)
!294 = !DISubprogram(name: "nextafter", scope: !32, file: !32, line: 1098, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !296, file: !42, line: 1172)
!296 = !DISubprogram(name: "nextafterf", scope: !32, file: !32, line: 1099, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !298, file: !42, line: 1173)
!298 = !DISubprogram(name: "nextafterl", scope: !32, file: !32, line: 1100, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!299 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !300, file: !42, line: 1175)
!300 = !DISubprogram(name: "nexttoward", scope: !32, file: !32, line: 1103, type: !301, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!301 = !DISubroutineType(types: !302)
!302 = !{!41, !41, !110}
!303 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !304, file: !42, line: 1176)
!304 = !DISubprogram(name: "nexttowardf", scope: !32, file: !32, line: 1104, type: !305, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!305 = !DISubroutineType(types: !306)
!306 = !{!99, !99, !110}
!307 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !308, file: !42, line: 1177)
!308 = !DISubprogram(name: "nexttowardl", scope: !32, file: !32, line: 1105, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !310, file: !42, line: 1179)
!310 = !DISubprogram(name: "remainder", scope: !32, file: !32, line: 1053, type: !49, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!311 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !312, file: !42, line: 1180)
!312 = !DISubprogram(name: "remainderf", scope: !32, file: !32, line: 1054, type: !133, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!313 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !314, file: !42, line: 1181)
!314 = !DISubprogram(name: "remainderl", scope: !32, file: !32, line: 1055, type: !137, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !316, file: !42, line: 1183)
!316 = !DISubprogram(name: "remquo", scope: !32, file: !32, line: 1058, type: !317, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!317 = !DISubroutineType(types: !318)
!318 = !{!41, !41, !41, !69}
!319 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !320, file: !42, line: 1184)
!320 = !DISubprogram(name: "remquof", scope: !32, file: !32, line: 1059, type: !321, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!321 = !DISubroutineType(types: !322)
!322 = !{!99, !99, !99, !69}
!323 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !324, file: !42, line: 1185)
!324 = !DISubprogram(name: "remquol", scope: !32, file: !32, line: 1060, type: !325, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!325 = !DISubroutineType(types: !326)
!326 = !{!110, !110, !110, !69}
!327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !328, file: !42, line: 1187)
!328 = !DISubprogram(name: "rint", scope: !32, file: !32, line: 937, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !330, file: !42, line: 1188)
!330 = !DISubprogram(name: "rintf", scope: !32, file: !32, line: 938, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !332, file: !42, line: 1189)
!332 = !DISubprogram(name: "rintl", scope: !32, file: !32, line: 939, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !334, file: !42, line: 1191)
!334 = !DISubprogram(name: "round", scope: !32, file: !32, line: 1030, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!335 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !336, file: !42, line: 1192)
!336 = !DISubprogram(name: "roundf", scope: !32, file: !32, line: 1031, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!337 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !338, file: !42, line: 1193)
!338 = !DISubprogram(name: "roundl", scope: !32, file: !32, line: 1032, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!339 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !340, file: !42, line: 1195)
!340 = !DISubprogram(name: "scalbln", scope: !32, file: !32, line: 871, type: !341, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!341 = !DISubroutineType(types: !342)
!342 = !{!41, !41, !258}
!343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !344, file: !42, line: 1196)
!344 = !DISubprogram(name: "scalblnf", scope: !32, file: !32, line: 872, type: !345, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!345 = !DISubroutineType(types: !346)
!346 = !{!99, !99, !258}
!347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !348, file: !42, line: 1197)
!348 = !DISubprogram(name: "scalblnl", scope: !32, file: !32, line: 873, type: !349, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!349 = !DISubroutineType(types: !350)
!350 = !{!110, !110, !258}
!351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !352, file: !42, line: 1199)
!352 = !DISubprogram(name: "scalbn", scope: !32, file: !32, line: 867, type: !72, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !354, file: !42, line: 1200)
!354 = !DISubprogram(name: "scalbnf", scope: !32, file: !32, line: 868, type: !355, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!355 = !DISubroutineType(types: !356)
!356 = !{!99, !99, !35}
!357 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !358, file: !42, line: 1201)
!358 = !DISubprogram(name: "scalbnl", scope: !32, file: !32, line: 869, type: !359, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!359 = !DISubroutineType(types: !360)
!360 = !{!110, !110, !35}
!361 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !362, file: !42, line: 1203)
!362 = !DISubprogram(name: "tgamma", scope: !32, file: !32, line: 918, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !364, file: !42, line: 1204)
!364 = !DISubprogram(name: "tgammaf", scope: !32, file: !32, line: 919, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!365 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !366, file: !42, line: 1205)
!366 = !DISubprogram(name: "tgammal", scope: !32, file: !32, line: 920, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!367 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !368, file: !42, line: 1207)
!368 = !DISubprogram(name: "trunc", scope: !32, file: !32, line: 1044, type: !39, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!369 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !370, file: !42, line: 1208)
!370 = !DISubprogram(name: "truncf", scope: !32, file: !32, line: 1045, type: !104, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!371 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !30, entity: !372, file: !42, line: 1209)
!372 = !DISubprogram(name: "truncl", scope: !32, file: !32, line: 1046, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPrototyped, isOptimized: false)
!373 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !26, entity: !30, file: !15, line: 5)
!374 = !DILocation(line: 9, column: 9, scope: !6)
