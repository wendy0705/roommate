//package com.example.roommate.controller;

//@RestController
//public class DormController {
//
//    @Autowired
//    private DormService dormService;

//    @PostMapping("/submitDormData")
//    public ResponseEntity<?> aveAndFindMatchingUsers(@RequestBody DormDto dormDto) {
//        dormService.saveDormData(dormDto);
//        List<Long> matchingUserIds = dormService.findMatchingUserIds(dormDto);
//        return ResponseEntity.ok(matchingUserIds);
////        boolean isMatchFound = dormService.compareDormData(appliedDorm, school, dormitoryName, roomType);
////        if (isMatchFound) {
////            return ResponseEntity.ok("已找到相似宿舍資料！");
////        } else {
////            return ResponseEntity.ok("沒有找到相似的宿舍資料。");
////        }
//    }
//}
