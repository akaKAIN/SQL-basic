select km.number       as km,
       joints.number   as joint,
       suffixes.suffix as suffix,
       marks.code      as welder,
       date(w.created_at)    as `date`
from joints as j
         join km_nums as km on w.km_num_id = km.id
         join weld_nums as joints on w.weld_num_id = joints.id
         join interface_types as suffixes on w.interface_type_id = suffixes.id
         join welders_marks as marks on w.welder_mark_id = marks.id;