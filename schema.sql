USE biz;

CREATE TABLE `widgets` (
  `id` binary(16) NOT NULL,
  `row_num` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `name`  varchar(255),
  `data` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_id_widgets_row_num`(`row_num`),
  KEY `index_id_widgets_account_id_created_at`(`account_id`, `created_at`),
  KEY `index_id_widgets_name_data`(`name`, `data`(20),`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
