/*
 Navicat Premium Data Transfer

 Source Server         : ZZ - SomosSalud
 Source Server Type    : MySQL
 Source Server Version : 100529
 Source Host           : zz.com.ve:3306
 Source Schema         : javier_ponciano_5

 Target Server Type    : MySQL
 Target Server Version : 100529
 File Encoding         : 65001

 Date: 27/11/2025 19:32:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for atencion_adjuntos
-- ----------------------------
DROP TABLE IF EXISTS `atencion_adjuntos`;
CREATE TABLE `atencion_adjuntos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `atencion_id` bigint UNSIGNED NOT NULL,
  `ruta` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_original` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `atencion_adjuntos_atencion_id_foreign`(`atencion_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of atencion_adjuntos
-- ----------------------------

-- ----------------------------
-- Table structure for atencion_medicamentos
-- ----------------------------
DROP TABLE IF EXISTS `atencion_medicamentos`;
CREATE TABLE `atencion_medicamentos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `atencion_id` bigint UNSIGNED NOT NULL,
  `nombre_generico` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentacion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `posologia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `frecuencia` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `duracion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `orden` smallint UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `atencion_medicamentos_atencion_id_foreign`(`atencion_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of atencion_medicamentos
-- ----------------------------

-- ----------------------------
-- Table structure for atenciones
-- ----------------------------
DROP TABLE IF EXISTS `atenciones`;
CREATE TABLE `atenciones`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `titular_id` bigint UNSIGNED NULL DEFAULT NULL,
  `titular_nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `titular_cedula` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `titular_telefono` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `clinica_id` bigint UNSIGNED NOT NULL,
  `empresa` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `recepcionista_id` bigint UNSIGNED NULL DEFAULT NULL,
  `nombre_operador` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `especialidad_id` bigint UNSIGNED NULL DEFAULT NULL,
  `aseguradora` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `numero_siniestro` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seguro_validado` tinyint(1) NOT NULL DEFAULT 0,
  `validado_at` timestamp NULL DEFAULT NULL,
  `validado_por` bigint UNSIGNED NULL DEFAULT NULL,
  `estado` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'validado',
  `iniciada_at` timestamp NULL DEFAULT NULL,
  `atendida_at` timestamp NULL DEFAULT NULL,
  `cerrada_at` timestamp NULL DEFAULT NULL,
  `diagnostico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `atenciones_paciente_id_foreign`(`paciente_id`) USING BTREE,
  INDEX `atenciones_clinica_id_foreign`(`clinica_id`) USING BTREE,
  INDEX `atenciones_recepcionista_id_foreign`(`recepcionista_id`) USING BTREE,
  INDEX `atenciones_especialidad_id_foreign`(`especialidad_id`) USING BTREE,
  INDEX `atenciones_validado_por_foreign`(`validado_por`) USING BTREE,
  INDEX `atenciones_estado_medico_id_index`(`estado`) USING BTREE,
  INDEX `atenciones_titular_id_foreign`(`titular_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of atenciones
-- ----------------------------

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|::1:timer', 'i:1764181352;', 1764181352);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|::1', 'i:3;', 1764181352);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|38.41.23.21:timer', 'i:1764263516;', 1764263516);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|38.41.23.21', 'i:1;', 1764263516);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345679|38.41.23.21:timer', 'i:1764263495;', 1764263495);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345679|38.41.23.21', 'i:1;', 1764263495);
INSERT INTO `cache` VALUES ('somossalud-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}', 1764273749);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|82.86.113.138:timer', 'i:1764285047;', 1764285047);
INSERT INTO `cache` VALUES ('somossalud-cache-v-12345678|82.86.113.138', 'i:1;', 1764285047);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for cita_adjuntos
-- ----------------------------
DROP TABLE IF EXISTS `cita_adjuntos`;
CREATE TABLE `cita_adjuntos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cita_id` bigint UNSIGNED NOT NULL,
  `ruta` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_original` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cita_adjuntos_cita_id_foreign`(`cita_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cita_adjuntos
-- ----------------------------

-- ----------------------------
-- Table structure for cita_medicamentos
-- ----------------------------
DROP TABLE IF EXISTS `cita_medicamentos`;
CREATE TABLE `cita_medicamentos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cita_id` bigint UNSIGNED NOT NULL,
  `nombre_generico` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `presentacion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `posologia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `frecuencia` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `duracion` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `orden` smallint UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cita_medicamentos_cita_id_foreign`(`cita_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cita_medicamentos
-- ----------------------------

-- ----------------------------
-- Table structure for citas
-- ----------------------------
DROP TABLE IF EXISTS `citas`;
CREATE TABLE `citas`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `clinica_id` bigint UNSIGNED NOT NULL,
  `especialista_id` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `precio` decimal(8, 2) NOT NULL DEFAULT 0.00,
  `precio_descuento` decimal(8, 2) NULL DEFAULT NULL,
  `estado` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `diagnostico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tratamiento` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `medicamentos_texto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `concluida_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `citas_usuario_id_foreign`(`usuario_id`) USING BTREE,
  INDEX `citas_clinica_id_foreign`(`clinica_id`) USING BTREE,
  INDEX `citas_especialista_id_foreign`(`especialista_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of citas
-- ----------------------------

-- ----------------------------
-- Table structure for clinicas
-- ----------------------------
DROP TABLE IF EXISTS `clinicas`;
CREATE TABLE `clinicas`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `descuento` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Porcentaje de descuento para afiliados',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clinicas
-- ----------------------------
INSERT INTO `clinicas` VALUES (1, 'SaludSonrisa', 'Calabozo, Guarico, Venezuela', 'saludsonrisa@clinicasaludsonrisa.com.ve', '+58-246-8716474', 0, '2025-11-26 16:39:53', '2025-11-26 16:39:53');

-- ----------------------------
-- Table structure for disponibilidades
-- ----------------------------
DROP TABLE IF EXISTS `disponibilidades`;
CREATE TABLE `disponibilidades`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `especialista_id` bigint UNSIGNED NOT NULL,
  `dia_semana` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `disp_especialista_intervalo_unique`(`especialista_id`, `dia_semana`, `hora_inicio`, `hora_fin`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of disponibilidades
-- ----------------------------
INSERT INTO `disponibilidades` VALUES (1, 28, 'monday', '08:30:00', '12:00:00', '2025-11-26 20:21:46', '2025-11-26 20:21:46');
INSERT INTO `disponibilidades` VALUES (2, 28, 'tuesday', '15:00:00', '17:00:00', '2025-11-26 20:22:12', '2025-11-26 20:22:12');
INSERT INTO `disponibilidades` VALUES (3, 28, 'wednesday', '10:00:00', '12:30:00', '2025-11-26 20:22:35', '2025-11-26 20:22:35');
INSERT INTO `disponibilidades` VALUES (4, 28, 'thursday', '10:00:00', '12:30:00', '2025-11-26 20:23:10', '2025-11-26 20:23:10');
INSERT INTO `disponibilidades` VALUES (5, 28, 'friday', '08:00:00', '12:30:00', '2025-11-26 20:23:34', '2025-11-26 20:23:34');

-- ----------------------------
-- Table structure for especialidad_usuario
-- ----------------------------
DROP TABLE IF EXISTS `especialidad_usuario`;
CREATE TABLE `especialidad_usuario`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `especialidad_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `usuario_especialidad`(`usuario_id`, `especialidad_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of especialidad_usuario
-- ----------------------------
INSERT INTO `especialidad_usuario` VALUES (1, 28, 6, '2025-11-26 20:09:09', '2025-11-26 20:09:09');
INSERT INTO `especialidad_usuario` VALUES (2, 29, 1, '2025-11-26 21:27:00', '2025-11-26 21:27:00');
INSERT INTO `especialidad_usuario` VALUES (3, 2, 2, '2025-11-26 21:29:34', '2025-11-26 21:29:34');
INSERT INTO `especialidad_usuario` VALUES (4, 4, 5, '2025-11-26 21:30:28', '2025-11-26 21:30:28');
INSERT INTO `especialidad_usuario` VALUES (5, 10, 1, '2025-11-26 21:32:07', '2025-11-26 21:32:07');
INSERT INTO `especialidad_usuario` VALUES (6, 12, 19, '2025-11-26 21:33:12', '2025-11-26 21:33:12');
INSERT INTO `especialidad_usuario` VALUES (7, 13, 9, '2025-11-26 21:33:32', '2025-11-26 21:33:32');
INSERT INTO `especialidad_usuario` VALUES (8, 14, 11, '2025-11-26 21:33:52', '2025-11-26 21:33:52');
INSERT INTO `especialidad_usuario` VALUES (9, 17, 6, '2025-11-26 21:34:51', '2025-11-26 21:34:51');
INSERT INTO `especialidad_usuario` VALUES (10, 18, 15, '2025-11-26 21:35:14', '2025-11-26 21:35:14');
INSERT INTO `especialidad_usuario` VALUES (11, 20, 2, '2025-11-26 21:35:55', '2025-11-26 21:35:55');
INSERT INTO `especialidad_usuario` VALUES (12, 22, 1, '2025-11-26 21:36:25', '2025-11-26 21:36:25');
INSERT INTO `especialidad_usuario` VALUES (13, 26, 24, '2025-11-26 21:37:47', '2025-11-26 21:37:47');
INSERT INTO `especialidad_usuario` VALUES (14, 27, 12, '2025-11-26 21:38:07', '2025-11-26 21:38:07');
INSERT INTO `especialidad_usuario` VALUES (15, 32, 13, '2025-11-27 18:42:50', '2025-11-27 18:42:50');
INSERT INTO `especialidad_usuario` VALUES (16, 33, 9, '2025-11-27 18:49:18', '2025-11-27 18:49:18');
INSERT INTO `especialidad_usuario` VALUES (18, 34, 1, '2025-11-27 18:56:31', '2025-11-27 18:56:31');
INSERT INTO `especialidad_usuario` VALUES (19, 35, 1, '2025-11-27 19:02:35', '2025-11-27 19:02:35');

-- ----------------------------
-- Table structure for especialidades
-- ----------------------------
DROP TABLE IF EXISTS `especialidades`;
CREATE TABLE `especialidades`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `especialidades_nombre_unique`(`nombre`) USING BTREE,
  UNIQUE INDEX `especialidades_slug_unique`(`slug`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of especialidades
-- ----------------------------
INSERT INTO `especialidades` VALUES (1, 'Medicina General', 'medicina-general', NULL, '2025-11-06 00:10:20', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (2, 'Pediatría', 'pediatria', NULL, '2025-11-06 00:10:20', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (24, 'Psicología', 'psicologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (3, 'Odontología', 'odontologia', NULL, '2025-11-06 00:10:20', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (20, 'Oftalmología', 'oftalmologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (4, 'Ginecología', 'ginecologia', NULL, '2025-11-06 00:10:20', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (5, 'Cardiología', 'cardiologia', NULL, '2025-11-06 00:10:20', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (7, 'Cirugía', 'cirugia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (6, 'Anestesiología', 'anestesiologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (8, 'Dermatología', 'dermatologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (9, 'Ecografía', 'ecografia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (10, 'Enfermería', 'enfermeria', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (11, 'Fisioterapia', 'fisioterapia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (12, 'Fisitría', 'fisitria', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (13, 'Gastrología', 'gastrologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (14, 'Laboratorio', 'laboratorio', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (15, 'Medicina Interna', 'medicina-interna', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (16, 'Nefrología', 'nefrologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (17, 'Neumología', 'neumologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (18, 'Neurología', 'neurologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (19, 'Nutrición', 'nutricion', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (21, 'Oncología', 'oncologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (22, 'Ortodoncia', 'ortodoncia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (23, 'Otorrinología', 'otorrinologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (25, 'Psiquiatría', 'psiquiatria', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (26, 'Quirofano', 'quirofano', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (27, 'Traumatología', 'traumatologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');
INSERT INTO `especialidades` VALUES (28, 'Urología', 'urologia', NULL, '2025-11-06 01:45:30', '2025-11-06 01:45:30');

-- ----------------------------
-- Table structure for exchange_rates
-- ----------------------------
DROP TABLE IF EXISTS `exchange_rates`;
CREATE TABLE `exchange_rates`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BCV',
  `from` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `to` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'VES',
  `rate` decimal(12, 6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_rate_date_source_pair`(`date`, `source`, `from`, `to`) USING BTREE,
  INDEX `exchange_rates_date_index`(`date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exchange_rates
-- ----------------------------
INSERT INTO `exchange_rates` VALUES (1, '2025-11-26', 'BCV', 'USD', 'VES', 243.572700, '2025-11-26 17:00:27', '2025-11-26 17:00:27');
INSERT INTO `exchange_rates` VALUES (2, '2025-11-27', 'BCV', 'USD', 'VES', 244.650400, '2025-11-27 00:16:17', '2025-11-27 00:16:17');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for items_solicitud_inventario
-- ----------------------------
DROP TABLE IF EXISTS `items_solicitud_inventario`;
CREATE TABLE `items_solicitud_inventario`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `solicitud_id` bigint UNSIGNED NOT NULL,
  `material_id` bigint UNSIGNED NULL DEFAULT NULL,
  `nombre_item` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `unidad_medida` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cantidad_solicitada` int NOT NULL,
  `cantidad_aprobada` int NULL DEFAULT NULL,
  `cantidad_despachada` int NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `items_solicitud_inventario_material_id_foreign`(`material_id`) USING BTREE,
  INDEX `items_solicitud_inventario_solicitud_id_index`(`solicitud_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of items_solicitud_inventario
-- ----------------------------
INSERT INTO `items_solicitud_inventario` VALUES (1, 1, 8, 'AGUA OXIGENADA GALÓN GUARDIAN (GALON)', NULL, 'Unidad', 1, 3, NULL, NULL, '2025-11-27 16:01:01', '2025-11-27 16:02:25');
INSERT INTO `items_solicitud_inventario` VALUES (2, 1, 4, 'GUANTES DE EXAMEN LÁTEX TALLA S (CAJA)', NULL, 'Caja', 1, 1, NULL, NULL, '2025-11-27 16:01:01', '2025-11-27 16:02:25');
INSERT INTO `items_solicitud_inventario` VALUES (3, 1, 6, 'HOJILLA DE BISTURI NRO 10 (CAJA)', NULL, 'Unidad', 5, 5, NULL, NULL, '2025-11-27 16:01:01', '2025-11-27 16:02:25');
INSERT INTO `items_solicitud_inventario` VALUES (4, 2, 3, 'GUANTES DE EXAMEN TALLA M (CAJA)', NULL, 'Unidad', 1, NULL, NULL, NULL, '2025-11-27 16:42:57', '2025-11-27 16:42:57');
INSERT INTO `items_solicitud_inventario` VALUES (5, 2, 2, 'CATGUT CRÓMICO 1 (813) (CAJA)', NULL, 'Caja', 1, NULL, NULL, NULL, '2025-11-27 16:42:57', '2025-11-27 16:42:57');
INSERT INTO `items_solicitud_inventario` VALUES (6, 2, 5, 'CUBRE BOTA PAQX100 UNDS (PAQUETE)', NULL, 'Unidad', 1, NULL, NULL, NULL, '2025-11-27 16:42:57', '2025-11-27 16:42:57');

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------
INSERT INTO `jobs` VALUES (1, 'default', '{\"uuid\":\"7b1108dc-c3a6-4211-b73d-c1e048431490\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762612846,\"delay\":null}', 0, NULL, 1762612847, 1762612847);
INSERT INTO `jobs` VALUES (2, 'default', '{\"uuid\":\"739f7199-bffe-4c84-970a-b0550d451f1b\",\"displayName\":\"App\\\\Mail\\\\CitaActualizada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:24:\\\"App\\\\Mail\\\\CitaActualizada\\\":5:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:4:\\\"tipo\\\";s:9:\\\"cancelada\\\";s:13:\\\"fechaAnterior\\\";s:19:\\\"2025-11-10 10:30:00\\\";s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762642782,\"delay\":null}', 0, NULL, 1762642782, 1762642782);
INSERT INTO `jobs` VALUES (3, 'default', '{\"uuid\":\"1e00aa58-bd5a-4e65-a14e-10f326570d18\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762643958,\"delay\":null}', 0, NULL, 1762643958, 1762643958);
INSERT INTO `jobs` VALUES (4, 'default', '{\"uuid\":\"0f3def6c-af19-4c6f-b8ab-cf5f913a1c1e\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762645275,\"delay\":null}', 0, NULL, 1762645275, 1762645275);
INSERT INTO `jobs` VALUES (5, 'default', '{\"uuid\":\"9103d6dc-b748-4752-82ed-99c34f67c6ab\",\"displayName\":\"App\\\\Mail\\\\CitaActualizada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:24:\\\"App\\\\Mail\\\\CitaActualizada\\\":5:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:4:\\\"tipo\\\";s:9:\\\"cancelada\\\";s:13:\\\"fechaAnterior\\\";s:19:\\\"2025-11-10 10:00:00\\\";s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762736965,\"delay\":null}', 0, NULL, 1762736965, 1762736965);
INSERT INTO `jobs` VALUES (6, 'default', '{\"uuid\":\"dd190ea7-0ee9-457f-8179-3f2743d95f94\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"YNAZACR26@GMAIL.OCM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762776217,\"delay\":null}', 0, NULL, 1762776217, 1762776217);
INSERT INTO `jobs` VALUES (7, 'default', '{\"uuid\":\"c60e5728-7883-4761-8f6a-0e696f4913c4\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"YNAZACR26@GMAIL.OCM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762776857,\"delay\":null}', 0, NULL, 1762776857, 1762776857);
INSERT INTO `jobs` VALUES (8, 'default', '{\"uuid\":\"a59c47de-e12b-4543-a5ff-febfbbda1034\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:15;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762780509,\"delay\":null}', 0, NULL, 1762780509, 1762780509);
INSERT INTO `jobs` VALUES (9, 'default', '{\"uuid\":\"e91c84eb-3ae0-42d6-86fa-aa0d6e744242\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:19:\\\"JPONCIANG@GMAIL.COM\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762780585,\"delay\":null}', 0, NULL, 1762780585, 1762780585);
INSERT INTO `jobs` VALUES (10, 'default', '{\"uuid\":\"4d51865a-5332-4c2b-9516-96f76c8e868d\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:16;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"alberto@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762782322,\"delay\":null}', 0, NULL, 1762782322, 1762782322);
INSERT INTO `jobs` VALUES (11, 'default', '{\"uuid\":\"602e05f1-45dc-4d56-9fc6-28d8155358a6\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"alberto@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762782426,\"delay\":null}', 0, NULL, 1762782426, 1762782426);
INSERT INTO `jobs` VALUES (12, 'default', '{\"uuid\":\"df912a49-2e07-4441-82a4-736012d4d155\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"admin@saludsonrisa.test\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762869970,\"delay\":null}', 0, NULL, 1762869970, 1762869970);
INSERT INTO `jobs` VALUES (13, 'default', '{\"uuid\":\"7b5a71c4-fb00-4b20-b6ab-c42cde1b8791\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"alberto@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762870264,\"delay\":null}', 0, NULL, 1762870264, 1762870264);
INSERT INTO `jobs` VALUES (14, 'default', '{\"uuid\":\"7d089dc4-6193-4552-9b14-5b9c7f705356\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"alberto@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762873035,\"delay\":null}', 0, NULL, 1762873035, 1762873035);
INSERT INTO `jobs` VALUES (15, 'default', '{\"uuid\":\"014677d5-8728-4b9f-a296-92a9bec43c8e\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:18;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762873289,\"delay\":null}', 0, NULL, 1762873289, 1762873289);
INSERT INTO `jobs` VALUES (16, 'default', '{\"uuid\":\"a96762dc-af48-4ed7-b0c2-86c31f2924bb\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762873369,\"delay\":null}', 0, NULL, 1762873369, 1762873369);
INSERT INTO `jobs` VALUES (17, 'default', '{\"uuid\":\"e238a27c-595c-4e00-ae4c-d08545535abc\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762873420,\"delay\":null}', 0, NULL, 1762873420, 1762873420);
INSERT INTO `jobs` VALUES (18, 'default', '{\"uuid\":\"747dc85a-5e8f-40ab-a257-2f3a2403036b\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762873489,\"delay\":null}', 0, NULL, 1762873489, 1762873489);
INSERT INTO `jobs` VALUES (19, 'default', '{\"uuid\":\"f8fe4a03-93aa-4b49-9c03-7da48dc3228d\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:20;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"yeniffer@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762889325,\"delay\":null}', 0, NULL, 1762889325, 1762889325);
INSERT INTO `jobs` VALUES (20, 'default', '{\"uuid\":\"c5246d71-62b3-4507-9caa-0724f9f1f9b4\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"yeniffer@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1762889404,\"delay\":null}', 0, NULL, 1762889404, 1762889404);
INSERT INTO `jobs` VALUES (21, 'default', '{\"uuid\":\"e61c3246-36cf-4bc8-9a8b-805f23851ca9\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"yeniffer@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1763397618,\"delay\":null}', 0, NULL, 1763397618, 1763397618);
INSERT INTO `jobs` VALUES (22, 'default', '{\"uuid\":\"915ecd69-0d3a-45cc-89e4-9d1baf87be93\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"yeniffer@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1763397665,\"delay\":null}', 0, NULL, 1763397665, 1763397665);
INSERT INTO `jobs` VALUES (23, 'default', '{\"uuid\":\"c6ea55dc-8676-437e-8596-99a6f462dcd4\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1763475644,\"delay\":null}', 0, NULL, 1763475644, 1763475644);
INSERT INTO `jobs` VALUES (24, 'default', '{\"uuid\":\"5bbfeb9d-0432-40a6-81b5-27d636398a45\",\"displayName\":\"App\\\\Mail\\\\CitaAgendada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:21:\\\"App\\\\Mail\\\\CitaAgendada\\\":3:{s:4:\\\"cita\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Cita\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:3:{i:0;s:7:\\\"usuario\\\";i:1;s:12:\\\"especialista\\\";i:2;s:7:\\\"clinica\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:27:\\\"telefonodevicente@gmail.com\\\";}}s:6:\\\"mailer\\\";s:3:\\\"log\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1763475703,\"delay\":null}', 0, NULL, 1763475703, 1763475703);
INSERT INTO `jobs` VALUES (25, 'default', '{\"uuid\":\"89a17095-5721-4779-8a2d-0f77d24208fd\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:25;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"paciente@test.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1763993450,\"delay\":null}', 0, NULL, 1763993450, 1763993450);
INSERT INTO `jobs` VALUES (26, 'default', '{\"uuid\":\"2f04455c-bfb2-4f5f-b5d0-258084650489\",\"displayName\":\"App\\\\Mail\\\\SuscripcionAprobada\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:28:\\\"App\\\\Mail\\\\SuscripcionAprobada\\\":4:{s:7:\\\"usuario\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:31;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"suscripcion\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\Suscripcion\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:30:\\\"hectorcorrosolorzano@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1764262699,\"delay\":null}', 0, NULL, 1764262699, 1764262699);

-- ----------------------------
-- Table structure for lab_categories
-- ----------------------------
DROP TABLE IF EXISTS `lab_categories`;
CREATE TABLE `lab_categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `lab_categories_code_unique`(`code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_categories
-- ----------------------------
INSERT INTO `lab_categories` VALUES (11, '001', 'HEMATOLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (12, '002', 'LIBRE', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (13, '003', 'UROANALISIS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (14, '004', 'SEROLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (15, '005', 'PRUEBAS ESPECIALES', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (16, '006', 'COAGULACION', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (17, '007', 'INMUNOLOGICOS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (18, '008', 'COPROLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (19, '013', 'MARCADORES HEPATITIS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (20, '014', 'MARCADORES TUMORALES', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (21, '022', 'ENDOCRINOLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (22, '026', 'BACTERIOLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (23, '027', 'BIOLOGÍA MOLECULAR / PCR', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (24, '029', 'MYCOPLASMA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (25, '030', 'CHLAMIDYA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (26, '031', 'TOXICOLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (27, '032', 'MISCELANEOS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (28, '033', 'ELECTROLITOS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (29, '034', 'BIOQUIMICA II', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (30, '036', 'CULTIVOS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (31, '037', 'CONSULTAS MEDICAS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (32, '038', 'ODONTOLOGIA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (33, '039', 'BANCO DE SANGRE', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (34, '040', 'QUIMICA', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (35, '041', 'PRUEBAS ESPECIALES II', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (36, '042', 'GASES', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (37, '043', 'HORMONAS TIROIDEAS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (38, '044', 'COVID19', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (39, '045', 'ALERGIAS', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (40, '046', 'ANTICOAGULANTE LUPICO', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (41, '047', 'PRUEBA DE EMBARAZO', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_categories` VALUES (42, '048', ' EXCESO DE BASE EFECTIVO', 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');

-- ----------------------------
-- Table structure for lab_exam_items
-- ----------------------------
DROP TABLE IF EXISTS `lab_exam_items`;
CREATE TABLE `lab_exam_items`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `lab_exam_id` bigint UNSIGNED NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `reference_value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lab_exam_items_lab_exam_id_foreign`(`lab_exam_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5897 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_exam_items
-- ----------------------------
INSERT INTO `lab_exam_items` VALUES (41, 15, '001', 'PLAQUETAS:', 'Plq/mm3', '150000.0 - 450000.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (42, 16, '001', 'V.S.G.:', 'mm/h', '< 13.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (43, 17, '001', 'P.T. CONTROL:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (44, 17, '002', 'P.T. PACIENTE:', 's', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (45, 18, '001', 'FIBRINÓGENO:', 'mg/dl', '200.0 - 400.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (46, 20, '001', 'CREATININA:', 'mg/dL', '0.5 - 1.4', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (47, 21, '001', 'COLESTEROL TOTAL:', 'mg/dL', '> 200.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (48, 23, '001', 'ÁCIDO ÚRICO:', 'mg/dL', '1.5 - 7.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (49, 26, '001', 'CALCIO:', 'mg/dL', '8.5 - 10.5', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (50, 27, '001', 'FÓSFORO:', 'mg/dL', '2.5 - 4.8', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (51, 28, '001', 'MAGNESIO:', 'meq/L', '1.5 - 2.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (52, 34, '001', 'PROTEÍNAS TOTALES:', 'g/dL', '6.3 - 8.5', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (53, 34, '002', 'ALBÚMINA:', 'g/dL', '3.5 - 5.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (54, 30, '001', 'EPAMIN:', 'ug/mL', '10.0 - 20.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (55, 31, '001', 'CARBAMAZEPINA:', 'ug/mL', '4.0 - 10.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (56, 33, '001', 'C.K.M.B.:', 'U/L', '< 25.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (57, 35, '001', 'MONO-TEST:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (58, 36, '001', 'COMPLEMENTO C3', 'g/L', '0.9 - 1.8', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (59, 37, '001', 'CH 50', 'UI/mL', '101.0 - 300.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (60, 38, '001', 'IgG SÉRICA:', 'g/L', '7.0 - 16.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (61, 39, '001', 'IgM SÉRICA:', 'g/L', '0.4 - 2.3', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (62, 25, '001', 'FOSFATASA ÁCIDA-PROSTÁTICA:', 'UI/L', '> 3.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (63, 41, '002', 'ASPECTO:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (64, 41, '004', 'CONSISTENCIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (65, 41, '006', 'COLOR:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (66, 41, '007', 'SANGRE:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (67, 41, '008', 'EXAMEN MICROSCÓPICO', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (68, 42, '001', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (69, 43, '001', 'IgA SECRETORA:', 'mg/dL', '45.0 - 300.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (70, 46, '001', 'T3 TOTAL:', 'nmol/L', '0.6 - 1.85', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (71, 47, '001', 'T4 LIBRE:', 'pmol/l', '12.0 - 22.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (72, 56, '001', 'CA 19.9:', 'UI/mL', '> 37.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (73, 57, '001', 'CA 72.4:', 'UI/mL', '> 5.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (74, 58, '001', 'CA 125:', 'UI/mL', '> 35.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (75, 34, '003', 'GLOBULINA:', 'g/dL', '2.8 - 3.4', 'F', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (76, 61, '001', 'AZÚCARES REDUCTORES EN HECES:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (77, 64, '001', 'CELULAS L.E. TEST:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (78, 65, '001', 'RESULTADO', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (79, 59, '001', 'CETONEMIA:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (80, 60, '001', 'ALFAFETO PROTEÍNAS:', 'ng/mL', '< 9.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (81, 68, '001', 'PROLACTINA:', 'ng/mL', '4.6 - 25.07', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (82, 66, '001', 'VITAMINA B12:', 'pg/mL', '110.0 - 800.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (83, 63, '001', 'T3 LIBRE:', 'pmol/l', '2.8 - 7.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (84, 72, '001', 'CA 21.1:', 'UI/mL', '> 6.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (85, 69, '001', 'T4 TOTAL:', 'ug/dL', '4.8 - 11.6', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (86, 74, '001', 'INSULINA POSTCARGA:', 'uUI/mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (87, 67, '001', '(ANTI-TPO):', 'UI/ml', '> 40.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (88, 75, '000', 'FROTIS DE SANGRE PERIFÉRICA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (89, 75, '003', 'PLAQUETAS:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (90, 75, '005', 'SERIE BLANCA:', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (91, 77, '001', 'TIROGLOBULINA:', 'ng/mL', '> 50.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (92, 78, '001', 'GLICEMIA POSTPANDRIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (93, 79, '001', 'RESULTADO:', 'UI/mL', '< 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (94, 37, '002', '', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (95, 17, '003', 'RAZÓN:', '', '0.8 - 1.2', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (96, 55, '002', 'CA 15.3:', 'UI/mL', '> 35.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (97, 19, '002', 'UREA:', 'mg/dL', '10.0 - 40.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (98, 80, '001', 'TIPO DE MUESTRA:   ORINA', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (99, 81, '001', 'TIPO DE MUESTRA:  HECES', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (100, 81, '002', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (101, 81, '003', 'NOTA:', '', NULL, 'O', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (102, 81, '004', '.', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (103, 81, '005', 'GERMEN AISLADO:', '', NULL, 'O', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (104, 81, '006', 'ANTIBIOGRAMA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (105, 81, '007', 'SENSIBLE:', '', NULL, 'O', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (106, 81, '008', '.', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (107, 81, '009', 'INTERMEDIO:', '', NULL, 'O', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (108, 81, '010', '.', '', NULL, 'E', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (109, 81, '011', 'RESISTENTE:', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (110, 82, '001', 'TIPO DE MUESTRA: LIQUIDO SEMINAL', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (111, 82, '002', 'GRAM', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (112, 82, '003', 'GRAM:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (113, 82, '004', '.', '', NULL, 'O', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (114, 82, '005', '-', '', NULL, 'O', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (115, 82, '006', '-', '', NULL, 'O', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (116, 82, '007', '-', '', NULL, 'O', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (117, 82, '008', 'SENSIBLE:', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (118, 82, '009', '-', '', NULL, 'E', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (119, 82, '010', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (120, 82, '011', '-', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (121, 83, '001', 'GRUPO SANGUINEO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (122, 84, '001', 'PSA TOTAL:', 'ng/mL', '> 4.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (123, 82, '012', 'GERMEN AISLADO (1):', '', NULL, 'O', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (124, 82, '013', 'ANTIBIOGRAMA:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (125, 53, '001', 'HORMONA DE CRECIMIENTO BASAL', 'ng/mL', '0.14 - 11.2', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (126, 85, '002', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (127, 85, '003', 'CANTIDAD:', 'mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (128, 85, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (129, 85, '005', 'ASPECTO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (130, 85, '006', 'pH:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (131, 85, '007', 'DENSIDAD:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (132, 85, '008', 'DIRECTO:', '', NULL, 'O', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (133, 85, '010', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (134, 85, '011', 'CANTIDAD:', 'c.c.', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (135, 85, '012', 'COLOR:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (136, 85, '013', 'ASPECTO:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (137, 85, '014', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (138, 85, '015', 'GLUCOSA:', 'mg/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (139, 85, '016', 'PROTEINAS TOTALES:', 'g/dL', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (140, 85, '017', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (141, 85, '018', 'CÉLULAS:', 'x mm3', NULL, 'N', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (142, 85, '019', 'CITODIAGNÓSTICO DIFERENCIAL:', '', NULL, 'O', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (143, 73, '001', 'IgG RUBEOLA:', 'UI/mL', '> 2.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (144, 86, '001', 'PSA TOTAL:', 'ng/mL', '> 4.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (145, 87, '001', 'RESULTADO:', 'umol/L', '5.0 - 15.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (146, 87, '002', 'HOMOCISTEINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (147, 89, '001', 'INSULINA BASAL', 'uUI/mL', '2.26 - 24.19', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (148, 90, '001', 'IgG CMV:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (149, 91, '001', 'IgM CMV:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (150, 75, '008', 'SERIE ROJA:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (151, 95, '001', 'DEPURACION DE UREA:', 'mL/min', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (152, 95, '002', 'UREA EN ORINA:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (153, 95, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (154, 95, '004', 'VOLUMEN MINUTO:', 'mL/min', NULL, 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (155, 94, '001', 'R.A. TEST', 'IU/mL', '< 8.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (156, 96, '001', 'IgG HERPES:', 'UI/mL', '> 2.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (157, 96, '004', 'IGG:', 'UI/ml', '> 2.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (158, 97, '001', 'TESTOSTERONA TOTAL:', 'ng/dL', '0.08 - 0.35', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (159, 98, '001', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (160, 99, '001', 'INSULINA:', 'uUI/mL', '5.0 - 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (161, 101, '001', 'PROCALCITONINA:', 'ng/mL', '< 0.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (162, 102, '001', 'COMPLEMENTO C4', 'g/L', '0.1 - 0.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (163, 100, '003', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (164, 103, '001', 'IgG Chlamydia trachomatis:', 'Ul/mL', '> 0.9', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (165, 34, '004', 'RELACIÓN ALBÚMINA / GLOBULINAS:', '', '1.2 - 2.2', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (166, 107, '001', 'P.T.T. CONTROL:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (167, 107, '002', 'P.T.T. PACIENTE:', 's', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (168, 107, '005', 'DIFERENCIA:', '', '-6.0 - 6.0', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (169, 111, '001', 'COLESTEROL TOTAL:', 'mg/dL', '> 180.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (170, 111, '002', 'COLESTEROL H.D.L.:', 'mg/dL', '> 45.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (171, 111, '003', 'COLESTEROL L.D.L.:', 'mg/dL', '> 150.0', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (172, 111, '004', 'V.L.D.L.:', 'mg/dL', NULL, 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (173, 111, '006', 'TRIGLICERIDOS:', 'mg/dL', '30.0 - 150.0', 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (174, 112, '001', 'INSULINA POSTPRANDIAL', 'uUI/mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (175, 110, '001', 'COLESTEROL HDL:', 'mg/dL', '> 45.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (176, 41, '023', 'PARÁSITOS Y SUS FORMAS:', '', NULL, 'O', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (177, 105, '001', 'COCAINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (178, 106, '001', 'MARIHUANA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (179, 83, '002', 'FACTOR RhD:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (180, 50, '001', 'ESTRADIOL:', 'ng/mL', '> 56.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (181, 51, '001', 'PROGESTERONA:', 'ng/mL', '65.0 - 229.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (182, 48, '001', 'LH:', 'mUI/mL', '> 17.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (183, 108, '001', 'ANTIGENO CARCINOEMBRIONARIO (CEA):', 'ng/mL', '> 5.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (184, 80, '002', 'CONTAJE DE COLONIAS GERMEN (1):', 'UFC/mL', NULL, 'T', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (185, 80, '003', 'UROCULTIVO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (186, 80, '004', 'GERMEN AISLADO (1):', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (187, 80, '005', '', '', NULL, 'O', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (188, 80, '007', 'SENSIBLE:', '', NULL, 'O', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (189, 80, '008', 'RESISTENTE:', '', NULL, 'O', 25, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (190, 113, '001', 'IgM Helicobacter pylori:', 'Ul/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (191, 86, '003', 'PSA LIBRE:', 'ng/mL', '> 1.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (192, 86, '005', 'RELACION PSA LIBRE/PSA TOTAL', '%', '> 25.0', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (193, 108, '002', 'ANTÍGENO CARCINOEMBRIONARIO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (194, 114, '001', '17 OH PROGESTERONA:', 'ng/mL', '< 3.03', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (195, 115, '001', 'ANTI-CORE IGM. HEPATITIS B:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (196, 116, '001', 'ANTÍGENO DE SUPERFICIE:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (197, 117, '001', 'COLESTEROL LDL:', 'mg/dL', '> 150.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (198, 122, '001', 'COLESTEROL TOTAL:', 'mg/dL', '> 200.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (199, 122, '002', 'HDL:', 'mg/dL', '30.0 - 70.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (200, 122, '003', 'LDL:', 'mg/dL', '< 100.0', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (201, 123, '001', 'BILIRRUBINA TOTAL:', 'mg/dL', '> 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (202, 123, '002', 'BILIRRUBINA DIRECTA:', 'mg/dL', '> 0.2', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (203, 123, '003', 'BILIRRUBINA INDIRECTA:', 'mg/dL', '> 0.8', 'F', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (204, 41, '025', 'FLORA BACTERIANA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (205, 41, '026', 'LEUCOCITOS:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (206, 41, '027', 'HEMATÍES:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (207, 41, '029', 'LEVADURAS:', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (208, 41, '031', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (209, 41, '032', 'MOCO:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (210, 126, '001', 'A.S.L.O. TÍTULO DE ESTREPTOLISINA O', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (211, 127, '001', 'ALDOLASA:', 'UI/mL', '2.0 - 8.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (212, 128, '001', 'AMILASA EN ORINA:', 'UI/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (213, 130, '001', 'ANTI CARDIOLIPINAS IGG:', 'Ul/mL', '> 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (214, 129, '001', 'ANTI CARDIOLIPINAS IGM:', 'UI/ml', '12.0 - 18.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (215, 132, '001', 'IgG ANTI FOSFOLÍPIDOS:', 'UI/mL', '> 20.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (216, 131, '001', 'IgM ANTI FOSFOLÍPIDOS:', 'UI/mL', '> 20.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (217, 134, '001', 'ANTI HTLV I &II:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (218, 135, '001', 'ANTI PÉPTIDO CITRULINADO (ANTI CCP):', 'UI/mL', '> 12.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (219, 136, '001', 'ANTI RNA:', 'Ul/L', '> 11.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (220, 133, '001', 'ANTÍGENOS FEBRILES:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (221, 138, '001', 'IgG B2  GLICOPROTEINAS:', 'Ul/mL', '> 12.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (222, 137, '001', 'IgM B2 GLICOPROTEINAS:', 'UI/mL', '> 12.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (223, 175, '001', 'CALCIO EN ORINA 24 HORAS:', 'mg/24h', '42.2 - 353.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (224, 144, '001', 'CALCIO EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (225, 145, '001', 'CALCITONINA:', 'pg/mL', '> 10.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (226, 88, '001', 'IgM Chlamydia trachomatis:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (227, 146, '001', 'C.K.:', 'U/L', '< 170.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (228, 147, '001', 'CORTISOL 4:00 P.M.:', 'ng/mL', '20.0 - 150.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (229, 148, '001', 'CORTISOL URINARIO:', 'ug/24h', '9.0 - 53.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (230, 149, '001', 'CREATININA EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (231, 150, '001', 'CYPFRA 21-1:', 'UI/mL', '> 6.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (232, 151, '001', 'RESULTADO:', 'g/mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (233, 152, '001', 'DHEA-SO4', 'ug/mL', '6.0 - 79.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (234, 104, '003', 'IgM Epstein barr:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (235, 164, '001', 'FÓSFORO EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (236, 165, '001', 'FTA (TREPONEMA PALLIDUM)', 'UI/ml', '> 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (237, 166, '001', 'GASES VENOSOS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (238, 191, '001', 'IgM HERPES:', 'UI/mL', '0.9 - 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (239, 194, '001', 'IGF-1:', 'ng/mL', '75.0 - 212.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (240, 173, '001', 'UREA EN ORINA DE 24 HORAS:', 'g/24 h', '15.0 - 30.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (241, 197, '001', 'UREA EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (242, 172, '001', 'TIEMPO DE SANGRÍA:', 'min', '1.0 - 7.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (243, 200, '001', 'IgM RUBEOLA:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (244, 143, '001', 'RETRACCIÓN DEL COÁGULO:', '', '> 24.0', 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (245, 184, '001', 'RELACIÓN FÓSFORO/CREATININA (P/CR):', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (246, 183, '001', 'RESULTADO:', '', '> 0.2', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (247, 142, '001', 'PARATHORMONA (PTH):', 'pg/mL', '10.0 - 65.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (248, 141, '001', 'PROTEINURIA (PARCIAL):', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (249, 141, '002', 'PROTEINURIA (24HRS):', 'mg/24h', '42.0 - 225.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (250, 140, '001', 'PROTEINAS DE BENCE JONES:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (251, 163, '001', 'PÉPTIDO C:', 'ng/mL', '0.9 - 4.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (252, 155, '001', 'LDH:', 'U/L', '230.0 - 460.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (253, 121, '001', 'SODIO:', 'mEq/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (254, 121, '002', 'POTASIO:', 'mEq/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (255, 121, '003', 'CLORO:', 'mEq/L', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (256, 187, '001', 'CORTISOL 8:00 A.M.:', 'ng/mL', '50.0 - 230.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (257, 171, '001', 'IGFBP-3:', 'ng/mL', '12.2 - 40.4', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (258, 178, '001', 'ANDROSTENEDIONA:', 'ng/mL', '0.12 - 1.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (259, 120, '001', 'ELECTROLITOS SÉRICOS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (260, 120, '002', 'SODIO:', 'mEq/L', '135.0 - 150.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (261, 120, '003', 'POTASIO:', ' mEq/L', '3.5 - 5.5', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (262, 120, '004', 'CLORO:', 'mEq/L', '92.0 - 110.0', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (263, 202, '001', 'ANTI TG:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (264, 167, '001', 'GLUCOSURIA BASAL:', 'mg/dL', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (265, 168, '001', 'GLUCOSURIA P.P.:', 'mg/dL', '1.0 - 15.0', 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (266, 198, '001', 'HEPATITIS C:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (267, 203, '001', 'ANA:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (268, 170, '001', 'RESULTADO:', 'ng/mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (269, 44, '001', 'ANTI DNA:', '   UI/ L', '0.1 - 74.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (270, 159, '001', 'MAGNESIO EN ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (271, 196, '001', 'CAPACIDAD FIJACION FE (TIBC):', 'ug/dL', '250.0 - 400.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (272, 156, '001', 'POLIMORFONUCLEARES:', '%', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (273, 156, '002', 'MONONUCLEARES:', '%', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (274, 156, '004', 'LEUCOGRAMA FECAL', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (275, 158, '001', 'ASTO:', 'IU/mL', '< 200.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (276, 71, '001', 'H.C.G BETA CUANTIFICADA:', 'mUI/mL', '9040.0 - 56451.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (277, 157, '001', 'LIPASA:', 'UI/L', '< 190.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (278, 61, '003', 'AZUCARES REDUCTORES', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (279, 199, '001', 'ANTI HBsAg:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (280, 154, '001', 'FENOBARBITAL:', 'ug/mL', '15.0 - 45.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (281, 93, '001', 'IgG Epstein barr:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (282, 183, '002', 'CREATININA EN ORINA:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (283, 183, '003', 'CALCIO EN ORINA:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (284, 184, '002', 'FÓSFORO EN ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (285, 184, '003', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (286, 184, '004', 'RESULTADO:', '', '0.22 - 0.86', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (287, 192, '001', 'IgA SÉRICA:', 'g/L', '0.7 - 4.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (288, 206, '001', 'PSA LIBRE:', 'ng/mL', '< 1.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (289, 209, '001', 'ANTI BETA 2 GLICOPROTEÍNA IgG:', 'AU/mL', '> 70.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (290, 62, '001', 'ÁCIDO VALPROICO:', 'ug/mL', '50.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (291, 210, '001', 'LEUCOCITOS:', 'cel/mm3', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (292, 210, '002', 'DIFERENCIAL:', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (293, 210, '003', 'POLIMORFONUCLEARES', '%', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (294, 210, '004', 'MONONUCLEARES', '%', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (295, 210, '005', '', '', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (296, 210, '006', '', '', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (297, 67, '002', 'ANTICUERPOS ANTIMICROSOMALES/PEROXIDAZA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (298, 79, '007', 'ANTICUERPOS ANTIMITOCONDRIALES:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (299, 85, '022', 'CITOQUÍMICO LÍQUIDOS BIOLÓGICOS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (300, 210, '007', 'CUENTA Y FÓRMULA:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (301, 121, '004', 'ELECTROLITOS URINARIOS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (302, 82, '014', 'ESPERMOCULTIVO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (303, 174, '001', '%  SATURACIÓN DE LA TRANSFERINA:', '%', '20.0 - 55.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (304, 201, '001', 'V.L.D.L.:', '', '> 30.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (305, 189, '001', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (306, 189, '002', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (307, 189, '003', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (308, 189, '005', 'GLICEMIA 240 MIN:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (309, 111, '008', 'INDICE DE RIESGO (C.TOTAL/HDL)', '', '> 23.39', 'F', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (310, 111, '009', 'INDICE DE RIESGO (LDL/HDL)', '', '> 7.99', 'F', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (311, 111, '010', 'PERFIL LIPÍDICO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (312, 80, '009', 'INTERMEDIO:', '', NULL, 'O', 22, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (313, 139, '001', 'C1 INHIBIDOR:', 'mg/L', '315.0 - 385.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (314, 211, '001', 'ELECTROLITOS EN LÍQUIDO PERITONEAL', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (315, 211, '002', 'SODIO:', 'mEq/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (316, 211, '003', 'POTASIO:', 'mEq/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (317, 211, '004', 'CLORO:', 'mEq/L', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (318, 212, '002', 'COLESTEROL:', 'mg/dL', '> 200.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (319, 212, '003', 'TRIGLICÉRIDOS:', 'mg/dL', '> 165.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (320, 213, '001', 'ALBÚMINA:', 'g/dL', '3.5 - 5.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (321, 262, '001', 'CURVA GLUCOSA 0,30,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (322, 262, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (323, 262, '004', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (324, 262, '005', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (325, 262, '006', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (326, 262, '007', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (327, 262, '008', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (328, 261, '001', 'CURVA GLUCOSA 0,30,60 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (329, 261, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (330, 261, '003', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (331, 261, '004', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (332, 261, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (333, 261, '006', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (334, 261, '007', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (335, 263, '001', 'CURVA GLUCOSA 0,30,60,180 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (336, 263, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (337, 263, '003', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (338, 263, '004', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (339, 263, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (340, 263, '006', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (341, 263, '007', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (342, 263, '008', 'GLICEMIA 180 MIN:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (343, 263, '009', 'GLUCOSURIA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (344, 264, '001', 'CURVA GLUCOSA 0,30,60,120,180 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (345, 264, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (346, 264, '003', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (347, 264, '004', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (348, 264, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (349, 264, '006', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (350, 264, '007', 'GLUCOSURIA:', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (351, 264, '008', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (352, 264, '009', 'GLUCOSURIA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (353, 264, '010', 'GLICEMIA 180 MIN:', 'mg/dL', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (354, 264, '011', 'GLUCOSURIA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (355, 265, '001', 'CURVA GLUCOSA 0,30,60,90,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (356, 265, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (357, 265, '003', 'GLUCOSURIA:', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (358, 265, '004', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (359, 265, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (360, 265, '006', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (361, 265, '007', 'GLUCOSURIA:', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (362, 265, '008', 'GLICEMIA 90 MIN:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (363, 265, '009', 'GLUCOSURIA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (364, 265, '010', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (365, 265, '011', 'GLUCOSURIA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (366, 266, '001', 'CURVA GLUCOSA 0,60,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (367, 266, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (368, 266, '003', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (369, 266, '004', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (370, 266, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (371, 266, '006', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (372, 266, '007', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (373, 189, '006', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (374, 189, '007', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (375, 189, '009', 'GLUCOSURIA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (376, 189, '010', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (377, 267, '001', 'CURVA INSULINA 0,30,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (378, 267, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (379, 267, '003', 'INSULINA 30 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (380, 267, '004', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (381, 268, '001', 'CURVA INSULINA 0,30,60,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (382, 268, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (383, 268, '003', 'INSULINA 30 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (384, 268, '004', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (385, 268, '005', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (386, 273, '001', 'CURVA INSULINA 0,30,60', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (387, 273, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (388, 273, '003', 'INSULINA 30 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (389, 273, '004', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (390, 269, '001', 'CURVA INSULINA 0,60,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (391, 269, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (392, 269, '003', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (393, 269, '004', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (394, 271, '001', 'CURVA INSULINA 0,60,120,180 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (395, 271, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (396, 271, '003', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (397, 271, '004', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (398, 271, '005', 'INSULINA 180 MIN:', 'uUI/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (399, 272, '001', 'CURV INSULINA 0,60,120,180,240 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (400, 272, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (401, 272, '003', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (402, 272, '004', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (403, 272, '005', 'INSULINA 180 MIN:', 'uUI/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (404, 272, '006', 'INSULINA 240 MIN:', 'uUI/mL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (405, 270, '001', 'CURVA INSULINA 0,60,90,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (406, 270, '002', 'INSULINA BASAL:', 'uUI/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (407, 270, '003', 'INSULINA 60 MIN:', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (408, 270, '004', 'INSULINA 90 MIN:', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (409, 270, '005', 'INSULINA 120 MIN:', 'uUI/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (410, 274, '001', 'CURVA GLUCOSA 0,30,60,120 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (411, 274, '002', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (412, 274, '003', 'GLUCOSURIA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (413, 274, '004', 'GLICEMIA 30 MIN:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (414, 274, '005', 'GLUCOSURIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (415, 274, '006', 'GLICEMIA 60 MIN:', 'mg/dL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (416, 274, '007', 'GLUCOSURIA:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (417, 274, '008', 'GLICEMIA 120 MIN:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (418, 274, '009', 'GLUCOSURIA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (419, 225, '001', 'AMILASURIA EN 4 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (420, 225, '002', 'AMILASURIA EN 4 HORAS:', 'UI/4h', '4.0 - 37.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (421, 225, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (422, 221, '001', 'AMILASURIA EN 12 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (423, 221, '002', 'AMILASURIA EN 12 HORAS:', 'UI/12h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (424, 221, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (425, 222, '001', 'AMILASURIA EN 24 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (426, 222, '002', 'AMILASURIA EN 24 HORAS:', 'UI/24h', '50.0 - 140.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (427, 222, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (428, 224, '001', 'AMILASURIA EN 6 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (429, 224, '002', 'AMILASURIA EN 6 HORAS:', 'UI/6h', '50.0 - 140.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (430, 224, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (431, 223, '001', 'AMILASURIA EN 2 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (432, 223, '002', 'AMILASURIA EN 2 HORAS:', 'UI/2h', '4.0 - 37.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (433, 223, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (434, 214, '002', 'ÁCIDO ÚRICO EN ORINA DE 1 HORA:', 'mg/1h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (435, 214, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (436, 215, '001', 'ÁCIDO ÚRICO EN ORINA DE 2 HORAS:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (437, 215, '002', 'ACIDO URICO EN ORINA DE 2 HORAS', 'mg/2h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (438, 215, '003', 'VOLUMEN URINARIO', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (439, 216, '001', 'ÁCIDO ÚRICO EN ORINA DE 24 HORAS:', 'mg/24h', '250.0 - 750.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (440, 216, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (441, 217, '001', 'ÁCIDO ÚRICO EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (442, 218, '001', 'ALBÚMINA EN ORINA PARCIAL:', 'mg/L', '> 20.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (443, 220, '001', 'ALBUMINURIA EN 24 HORAS:', 'mg/24h', '> 30.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (444, 220, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (445, 219, '001', 'ALBUMINURIA EN 12 HORAS:', 'mg/12h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (446, 219, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (447, 175, '002', 'VOLUMEN URINARIO', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (448, 229, '001', 'CALCIO EN ORINA DE 12 HORAS:', 'mg/12h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (449, 229, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (450, 228, '001', 'CALCIO EN ORINA DE 2 HORAS:', 'mg/2h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (451, 228, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (452, 230, '001', 'CALCIO EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (453, 70, '001', 'CETONURIA:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (454, 186, '001', 'IgG Chlamydia pneumoniae:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (455, 185, '001', 'IgM Chlamydia pneumoniae:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (456, 231, '001', 'CITRATO EN ORINA DE 24 HORAS:', 'mg/24h', '320.0 - 1240.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (457, 231, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (458, 232, '001', 'CITRATO EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (459, 208, '001', 'CORE B:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (460, 233, '001', 'CREATININA EN ORINA DE 2 HORAS:', 'mg/2h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (461, 233, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (462, 235, '001', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', '500.0 - 2000.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (463, 235, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (464, 236, '001', 'CREATININA EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (465, 234, '001', 'CREATININA EN ORINA DE 12 HORAS:', 'mg/12h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (466, 234, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (467, 40, '001', 'DEPURACION DE CREATININA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (468, 40, '002', 'CREATININA EN SANGRE:', 'mg/dL', '0.5 - 1.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (469, 40, '003', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (470, 40, '004', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (471, 40, '005', 'VOLUMEN MINUTO:', 'mL/min', NULL, 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (472, 40, '006', 'PESO:', 'kg', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (473, 40, '007', 'TALLA:', 'm', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (474, 40, '008', 'SUPERFICIE CORPORAL:', 'm2', NULL, 'F', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (475, 40, '009', 'DEPURACION SIN CORREGIR:', 'mL/min', NULL, 'F', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (476, 40, '010', 'DEPURACION DE CREATININA CORREGIDA:', 'mL/min', NULL, 'F', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (477, 40, '011', 'CREATININA EN ORINA DE 24 HORAS:', 'g/24h', NULL, 'F', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (478, 95, '005', 'UREA EN SANGRE:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (479, 153, '001', 'ESPERMATOGRAMA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (480, 153, '002', 'DIAS DE ABSTINENCIA:', 'Dias', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (481, 153, '003', 'MÉTODO DE OBTENCIÓN DE LA MUESTRA:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (482, 153, '004', 'EXAMEN FÍSICO:', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (483, 153, '005', 'COLOR:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (484, 153, '006', 'AUTOLICUACIÓN:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (485, 153, '007', 'VISCOSIDAD:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (486, 153, '008', 'pH:', '', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (487, 153, '009', 'REACCIÓN:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (488, 153, '010', 'EXAMEN DE LA MOVILIDAD:', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (489, 153, '011', 'HORAS DESPUÉS DE EYACULADO:', 'h', NULL, 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (490, 153, '012', 'ESPERMATOZOIDES MÓVILES:', '%', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (491, 153, '013', 'ESPERMATOZOIDES INMÓVILES:', '%', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (492, 153, '014', 'EXAMEN DE LA ACTIVIDAD:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (493, 153, '015', 'GRADO 3 (TRASLACIÓN RÁPIDA):', '%', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (494, 153, '016', 'GRADO 2 (TRASLACIÓN LENTA):', '%', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (495, 153, '017', 'GRADO 1 (OSCILATORIOS):', '%', NULL, 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (496, 153, '018', 'EXAMEN MORTALIDAD (TEST EOSCINA)', '', NULL, 'E', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (497, 153, '019', 'INMÓVILES VIVOS A LA HORA:', '%', NULL, 'N', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (498, 153, '020', 'INMÓVILES MUERTOS A LA HORA:', '%', NULL, 'N', 21, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (499, 153, '021', 'EXAMEN DE LA CONCENTRACIÓN', '', NULL, 'E', 22, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (500, 153, '022', 'ESPERMATOZOIDES POR C.C.:', '', NULL, 'T', 23, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (501, 153, '023', 'RECUENTO TOTAL:', '', NULL, 'T', 24, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (502, 153, '024', 'FRUCTOSA:', 'mg/dL', '200.0 - 400.0', 'N', 25, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (503, 153, '025', 'EX. ELEMENTOS AGREGADOS', '', NULL, 'E', 26, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (504, 153, '026', 'LEUCOCITOS:', '', NULL, 'T', 27, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (505, 153, '027', 'CÉLULAS:', 'xC', NULL, 'T', 28, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (506, 153, '028', 'HEMATÍES:', '', NULL, 'T', 29, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (507, 153, '029', 'OTROS:', '', NULL, 'T', 30, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (508, 153, '030', 'EXAMEN DE LA MORFOLOGÍA', '', NULL, 'E', 31, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (509, 153, '031', 'NORMALES:', '%', NULL, 'N', 32, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (510, 153, '032', 'ANORMALES:', '%', NULL, 'N', 33, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (511, 153, '033', 'TIPOS ANORMALES', '', NULL, 'E', 34, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (512, 153, '034', 'CABEZA ALARGADA:', '%', NULL, 'N', 35, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (513, 153, '035', 'MICROCÉFALOS:', '%', NULL, 'N', 36, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (514, 153, '036', 'MACROCÉFALOS:', '%', NULL, 'N', 37, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (515, 153, '037', 'DOBLE FLAGELO:', '%', NULL, 'N', 38, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (516, 153, '038', 'FLAGELO ENROLLADO:', '%', NULL, 'N', 39, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (517, 153, '039', 'FLAGELO AUSENTE:', '%', NULL, 'N', 40, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (518, 153, '040', 'ANGULADO:', '%', NULL, 'N', 41, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (519, 124, '001', 'TIPO DE MUESTRA: HISOPADO FARÍNGEO', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (520, 124, '002', '-', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (521, 124, '003', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (522, 124, '004', '-', '', NULL, 'E', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (523, 248, '001', 'FÓSFORO EN ORINA DE 24 HORAS:', 'mg/24h', '> 1000.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (524, 248, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (525, 247, '001', 'FÓSFORO EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (526, 275, '001', 'FOSFORO EN ORINA DE 2 HORAS:', 'mg/2h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (527, 275, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (528, 165, '003', 'F.T.A.:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (529, 237, '001', 'GRAM:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (530, 237, '002', 'GRAM:', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (531, 41, '033', 'MÉTODOS UTILIZADOS:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (532, 41, '035', 'DIRECTO (SOL. SALINA Y LUGOL):', '', NULL, 'O', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (533, 279, '002', 'HEMATOCRITO:', '%', '35.0 - 55.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (534, 279, '003', 'PLAQUETAS:', 'plaq/mm3', '150.0 - 450.0', 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (535, 279, '004', 'GLÓBULOS BLANCOS:', 'cel/mm3', '4.0 - 10.0', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (536, 279, '005', 'RECUENTO DIFERENCIAL', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (537, 279, '009', 'EOSINÓFILOS:', '%', '< 6.0', 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (538, 279, '011', 'SEGMENTADOS NEUTRÓFILOS:', '%', '50.0 - 70.0', 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (539, 279, '012', 'LINFOCITOS:', '%', '20.0 - 40.0', 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (540, 279, '013', 'MONOCITOS:', '%', '< 8.0', 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (541, 279, '016', 'TOTAL RECUENTO DIFERENCIAL:', '%', NULL, 'F', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (542, 188, '001', 'HEMOCULTIVO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (543, 188, '002', 'TIPO DE MUESTRA: SANGRE', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (544, 188, '003', '.', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (545, 188, '004', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (546, 188, '005', '.', '', NULL, 'E', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (547, 188, '006', 'NOTA:', '', NULL, 'O', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (548, 188, '007', '.', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (549, 188, '008', 'GERMEN AISLADO:', '', NULL, 'O', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (550, 188, '009', '.', '', NULL, 'E', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (551, 188, '010', 'ANTIBIOGRAMA:', '', NULL, 'O', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (552, 188, '011', 'SENSIBLE:', '', NULL, 'O', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (553, 188, '012', '.', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (554, 188, '013', 'INTERMEDIO:', '', NULL, 'O', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (555, 188, '014', '.', '', NULL, 'E', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (556, 188, '015', 'RESISTENTE:', '', NULL, 'O', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (557, 188, '016', '.', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (558, 280, '001', 'INSULINA BASAL:', 'uU/mL', '5.0 - 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (559, 280, '002', 'INSULINA POSTPRANDIAL:', 'uU/mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (560, 238, '001', 'LIPASA EN ORINA DE 12 HORAS:', 'UI/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (561, 281, '001', 'MAGNESIO EN ORINA DE 24 HORAS:', 'mg/24h', '73.0 - 122.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (562, 281, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (563, 195, '001', 'IgG Mycoplasma pneumoniae:', 'UI/mL', '> 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (564, 160, '001', 'IgM Mycoplasma pneumoniae:', 'UI/mL', '> 1.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (565, 239, '001', 'NITROGENO EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (566, 240, '001', 'NITRÓGENO EN ORINA DE 24 HORAS:', 'g/24h', '7.0 - 14.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (567, 250, '001', 'pH EN HECES:', '', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (568, 249, '001', 'pH EN ORINA:', '', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (569, 162, '001', 'PLOMO', 'mg/dL', '< 10.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (570, 243, '001', 'PROTEINURIA EN 24 HORAS:', 'mg/24h', '> 225.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (571, 243, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (572, 242, '001', 'PROTEINURIA EN 12 HORAS:', 'mg/12h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (573, 242, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (574, 244, '001', 'PROTEINURIA MINUTADA:', 'mg/min', '> 11.2', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (575, 246, '001', 'RESULTADO:', '%', NULL, 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (576, 246, '002', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (577, 246, '003', 'CREATININA URINARIA:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (578, 246, '004', 'POTASIO SÉRICO:', 'mEq/L', '3.3 - 5.1', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (579, 246, '005', 'POTASIO URINARIO:', 'mEq/24h', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (580, 245, '001', 'REABSORCIÓN TUBULAR DE FOSFATO', '%', '85.0 - 95.0', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (581, 245, '002', 'FÓSFORO SÉRICO:', 'mg/dL', '2.5 - 4.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (582, 245, '003', 'FÓSFORO URINARIO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (583, 245, '004', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (584, 245, '005', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (585, 253, '001', 'RESULTADO:', '', '> 0.4', 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (586, 253, '002', 'ÁCIDO ÚRICO:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (587, 253, '003', 'CREATININA EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (588, 253, '004', 'CREATININA SÉRICA:', 'mg/dL', '0.4 - 1.3', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (589, 255, '001', 'RESULTADO:', 'mg/dL', NULL, 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (590, 255, '002', 'ÁCIDO ÚRICO EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (591, 255, '003', 'CREATININA SÉRICA:', 'mg/dL', '0.4 - 1.3', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (592, 255, '004', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (593, 254, '001', 'ÁCIDO ÚRICO EN ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (594, 254, '002', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (595, 254, '003', 'CREATININA SÉRICA:', 'mg/dL', '0.4 - 1.3', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (596, 254, '004', 'RESULTADO:', 'mg/dL', '> 0.4', 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (597, 256, '001', 'ALBÚMINA EN ORINA:', 'mg/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (598, 256, '002', 'CREATININA EN ORINA:', 'g/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (599, 256, '003', 'RESULTADO:', 'mg/g', '> 250.0', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (600, 251, '001', 'CALCIO EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (601, 251, '002', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (602, 251, '003', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (603, 251, '004', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (604, 252, '001', 'CALCIO EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (605, 252, '002', 'CREATININA EN SEGUNDA ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (606, 252, '003', 'RESULTADO:', '', '> 0.2', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (607, 257, '001', 'CITRATO EN ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (608, 257, '002', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (609, 257, '003', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (610, 282, '001', 'CITRATO EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (611, 282, '002', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (612, 282, '003', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (613, 258, '001', 'FÓSFORO EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (614, 258, '002', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (615, 258, '003', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (616, 258, '004', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (617, 259, '001', 'MAGNESIO EN ORINA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (618, 259, '002', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (619, 259, '003', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (620, 260, '001', 'OXALATO EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (621, 260, '002', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (622, 260, '003', 'RESULTADO:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (623, 80, '010', 'GRAM:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (624, 283, '001', 'RESULTADO:', 'UI/L', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (625, 284, '001', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (626, 285, '001', 'ÁCIDO ÚRICO NO DISOCIADO:', 'mg/L', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (627, 286, '001', 'ANTICUERPOS ANTITIROGLUBULINA:', 'UI/mL', '> 40.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (628, 286, '002', 'ANTICUERPOS ANTIPEROXIDASA:', 'UI/mL', '> 35.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (629, 287, '001', 'ANTICUERPOS PARA AMIBAS:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (630, 227, '001', 'AZÚCARES NO REDUTORES EN HECES:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (631, 226, '001', 'AZÚCARES REDUCTORES EN ORINA', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (632, 288, '001', 'B.K. CONCENTRADO:', '', NULL, 'O', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (633, 291, '001', 'B.K. DE ESPUTO:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (634, 291, '002', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (635, 289, '001', 'B.K. DIRECTO:', '', NULL, 'O', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (636, 290, '001', 'B.K. EN ORINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (637, 290, '002', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (638, 290, '003', '', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (639, 292, '001', 'MUESTRA 1:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (640, 292, '002', 'MUESTRA 2:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (641, 292, '003', 'MUESTRA 3:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (642, 293, '001', 'B2 MICROGLOBULINAS:', 'mg/L', '> 2.5', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (643, 294, '001', 'RESULTADO:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (644, 295, '001', 'ANTICUERPOS ANTIPEROXIDASA:', 'UI/mL', '> 40.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (645, 207, '001', 'CULTIVO Y ANTIBIOGRAMA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (646, 207, '002', 'TIPO DE MUESTRA:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (647, 207, '003', 'GRAM:', '', NULL, 'O', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (648, 207, '004', 'CONTAJE DE COLONIAS:', '', NULL, 'O', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (649, 207, '005', '.', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (650, 207, '006', 'GERMEN AISLADO (1):', '', NULL, 'O', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (651, 207, '007', 'ANTIBIOGRAMA:', '', NULL, 'T', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (652, 207, '008', 'SENSIBLE:', '', NULL, 'O', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (653, 207, '009', '.', '', NULL, 'O', 21, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (654, 207, '010', 'INTERMEDIO:', '', NULL, 'O', 22, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (655, 207, '011', '.', '', NULL, 'E', 23, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (656, 207, '012', 'RESISTENTE:', '', NULL, 'O', 24, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (657, 207, '013', 'OBSERVACIÓN:', '', NULL, 'O', 28, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (658, 207, '014', '.', '', NULL, 'E', 29, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (659, 207, '015', 'GERMEN AISLADO (2):', '', NULL, 'O', 30, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (660, 207, '016', 'ANTIBIOGRAMA:', '', NULL, 'T', 31, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (661, 207, '017', 'SENSIBLE:', '', NULL, 'O', 32, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (662, 207, '018', '.', '', NULL, 'O', 33, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (663, 207, '019', 'INTERMEDIO:', '', NULL, 'O', 34, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (664, 207, '020', '.', '', NULL, 'E', 35, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (665, 207, '021', 'RESISTENTE:', '', NULL, 'O', 36, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (666, 207, '022', 'OBSERVACIÓN:', '', NULL, 'O', 37, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (667, 207, '023', '.', '', NULL, 'E', 38, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (668, 207, '024', 'GERMEN AISLADO (3) :', '', NULL, 'O', 39, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (669, 207, '025', 'ANTIBIOGRAMA:', '', NULL, 'T', 40, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (670, 296, '001', 'ANTICUERPOS ANTI INSULINA:', 'UI/mL', '> 5.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (671, 297, '001', 'DEPURACIÓN DE CREATININA NIÑOS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (672, 297, '002', 'CREATININA EN SANGRE:', 'mg/dL', '0.5 - 1.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (673, 297, '003', 'CREATININA EN ORINA:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (674, 297, '004', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (675, 297, '005', 'VOLUMEN MINUTO:', 'mL/min', NULL, 'F', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (676, 297, '006', 'PESO:', 'kg', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (677, 297, '007', 'TALLA:', 'm', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (678, 297, '008', 'SUPERFICIE CORPORAL:', 'm2', NULL, 'F', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (679, 297, '009', 'DEPURACION SIN CORREGIR:', 'mL/min', NULL, 'F', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (680, 297, '010', 'DEPURACIÓN CORREGIDA:', 'mL/min', NULL, 'F', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (681, 297, '011', 'CREATININA EN ORINA DE 24 HORAS:', 'mg/24h', NULL, 'F', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (682, 302, '001', 'RESULTADO:', '%', '> 1.0', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (683, 302, '002', 'SODIO SÉRICO:', 'mEq/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (684, 302, '003', 'SODIO URINARIO:', 'mEq/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (685, 302, '004', 'CREATININA SÉRICA:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (686, 302, '005', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (687, 300, '001', 'RESULTADO:', '%', '> 15.0', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (688, 300, '002', 'FÓSFORO SÉRICO:', 'mg/dL', '2.4 - 4.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (689, 300, '003', 'FÓSFORO URINARIO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (690, 300, '004', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (691, 300, '005', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (692, 298, '001', 'ÁCIDO ÚRICO SÉRICO:', 'mg/dL', '2.5 - 7.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (693, 298, '002', 'ÁCIDO ÚRICO URINARIO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (694, 298, '003', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (695, 298, '004', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (696, 298, '005', 'EFAU:', '%', '4.4 - 10.0', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (697, 301, '001', 'POTASIO SÉRICO:', 'mEq/L', '3.5 - 5.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (698, 301, '002', 'POTASIO URINARIO:', 'mEq/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (699, 301, '003', 'CREATININA SÉRICA:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (700, 301, '004', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (701, 301, '005', 'EFK:', '%', '5.19 - 11.67', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (702, 299, '001', 'CALCIO SÉRICO:', 'mg/dL', '8.4 - 10.2', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (703, 299, '002', 'CALCIO URINARIO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (704, 299, '003', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (705, 299, '004', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (706, 299, '005', 'RESULTADO:', '%', NULL, 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (707, 304, '001', 'RESULTADO:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (708, 305, '001', 'RESULTADO:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (709, 306, '001', 'COLORACIÓN DE GRAM:', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (710, 307, '001', 'HEMOGLOBINA:', 'g/dL', '12.0 - 14.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (711, 307, '002', 'HEMATOCRITO:', '%', '42.0 - 54.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (712, 92, '001', 'K.O.H.:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (713, 92, '002', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (714, 308, '001', 'DETERMINACIONES EN SANGRE', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (715, 308, '002', 'CREATININA:', 'mg/dL', '0.5 - 1.4', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (716, 308, '003', 'ÁCIDO ÚRICO:', 'mg/dL', '2.5 - 7.5', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (717, 308, '004', 'CALCIO:', 'mg/dL', '9.0 - 11.5', 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (718, 308, '005', 'FÓSFORO:', 'mg/dL', '4.0 - 7.0', 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (719, 308, '006', 'MAGNESIO:', 'mg/dL', '1.6 - 2.6', 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (720, 308, '007', 'SODIO:', 'mEq/L', '135.0 - 150.0', 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (721, 308, '008', 'POTASIO:', 'mEq/L', '3.5 - 5.5', 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (722, 308, '009', 'CLORO:', 'mEq/L', '92.0 - 110.0', 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (723, 308, '010', 'FOSFATASA ALCALINA:', 'U/L', '65.0 - 300.0', 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (724, 308, '011', 'DETERMINACIONES EN ORINA', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (725, 308, '012', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (726, 308, '013', 'pH:', '', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (727, 308, '014', 'VOLUMEN URINARIO:', 'ml', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (728, 308, '015', 'DEPURACION DE CREATININA:', 'mL/min/SC', '70.0 - 130.0', 'F', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (729, 308, '016', 'FÓSFORO URINARIO:', 'g/24h', '0.4 - 1.3', 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (730, 308, '017', 'RELACION FÓSFORO / DEP. CREATININA:', '', NULL, 'F', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (731, 308, '018', 'SODIO URINARIO:', 'mEq/24h', '40.0 - 220.0', 'N', 21, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (732, 308, '019', 'POTASIO URINARIO:', 'mEq/24h', '20.0 - 125.0', 'N', 22, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (733, 308, '020', 'ÁCIDO ÚRICO URINARIO:', 'g/24h', '0.25 - 0.75', 'N', 23, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (734, 308, '021', 'ÁCIDO ÚRICO NO DISOCIADO:', 'mg/L', '> 99.0', 'F', 24, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (735, 308, '022', 'CITRATO:', 'mg/L', '320.0 - 1240.0', 'N', 25, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (736, 308, '023', 'CALCIO URINARIO:', 'mg/24h', '50.0 - 250.0', 'N', 26, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (737, 308, '024', 'RELACIÓN CALCIO kg:', 'mg/kg', '> 4.0', 'N', 27, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (738, 308, '025', 'RELACIÓN CALCIO/CREATININA:', 'mg/g', '> 140.0', 'F', 28, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (739, 308, '026', 'RELACIÓN CALCIO/DEPURACIÓN:', '', NULL, 'F', 29, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (740, 308, '027', 'MAGNESIO URINARIO:', 'mg/24h', '73.0 - 122.0', 'N', 30, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (741, 308, '028', 'OXALATO:', 'mg/24h', '13.0 - 38.0', 'N', 31, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (742, 308, '029', 'TIEMPO DE RECOLECCIÓN MUESTRA:', 'h', NULL, 'N', 32, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (743, 308, '030', 'PESO:', 'kg', NULL, 'N', 33, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (744, 308, '031', 'TALLA:', 'm', NULL, 'N', 34, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (745, 308, '032', 'SUPERFICIE CORPORAL:', 'm2', NULL, 'F', 35, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (746, 309, '001', 'PYLORISET (HELICOBACTER PYLORI):', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (747, 310, '001', 'CONTROL:', 's', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (748, 310, '002', 'PACIENTE:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (749, 310, '003', 'DELTA:', '', '-2.0 - 2.0', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (750, 311, '002', 'T.G.O.:', 'U/L', '> 38.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (751, 312, '001', 'UREA:', 'mg/dL', '10.0 - 50.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (752, 312, '002', 'CREATININA:', 'mg/dL', '0.5 - 1.4', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (753, 313, '001', 'SS-A', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (754, 313, '002', 'dsDNA', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (755, 313, '003', 'SS-B', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (756, 313, '004', 'Sm', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (757, 313, '005', 'RNP/Sm', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (758, 313, '006', 'Scl-70', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (759, 313, '007', 'Jo-1', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (760, 313, '008', 'CENP-B', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (761, 313, '009', 'NUCLEOSOMA', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (762, 313, '010', 'METODOLO UTILIZADO: INMUNOBLOT', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (763, 314, '001', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (764, 176, '002', 'ADENOVIRUS:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (765, 176, '003', 'ROTAVIRUS:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (766, 315, '001', 'ANTIGENO CONTRA Ag.e HB:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (767, 315, '002', 'ANTI HBE:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (768, 315, '003', 'METODO UTILIZADO: ELISA', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (769, 316, '001', 'METODO UTILIZADO: ELISA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (770, 316, '002', 'ANTI HBsAg:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (771, 316, '003', 'RESULTADO:', 'UI/mL', '> 10.1', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (772, 318, '001', 'C.T.X.:', 'ng/mL', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (773, 319, '001', 'CALCIO - FÓSFORO:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (774, 319, '002', 'CALCIO:', 'mg/mL', '9.0 - 11.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (775, 319, '003', 'FÓSFORO:', 'mg/dL', '3.0 - 7.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (776, 321, '001', 'CATECOLAMINAS EN SANGRE:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (777, 317, '001', 'BALANCE METABÓLICO ÓSEO:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (778, 317, '002', 'CALCIO SÉRICO:', 'mg/dL', '8.4 - 10.2', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (779, 317, '003', 'CALCIO URINARIO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (780, 317, '004', 'CREATININA SÉRICA:', 'mg/dL', '0.5 - 1.4', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (781, 317, '005', 'CREATININA URINARIA:', 'mg/dL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (782, 317, '006', 'RELACIÓN CALCIO/CREATININA:', '', '> 0.2', 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (783, 317, '007', 'FÓSFORO SÉRICO:', 'mg/dL', '2.4 - 4.8', 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (784, 317, '008', 'FÓSFORO URINARIO:', 'mg/dL', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (785, 317, '009', 'REABSORCIÓN TUBULAR DE FÓSFORO:', '%', '85.0 - 95.0', 'F', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (786, 317, '010', 'FOSFATASA ALCALINA:', 'UI/L', '50.0 - 126.0', 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (787, 317, '011', 'C.T.X.:', 'ng/mL', '0.2 - 2.58', 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (788, 122, '006', 'VLDL:', 'mg/dL', '2.0 - 30.0', 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (789, 337, '001', 'GLÓBULOS ROJOS:', 'cel/mm3', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (790, 402, '001', 'MONOCITOS:', '%', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (791, 402, '002', 'LINFOCITOS ATÍPICOS:', '%', NULL, 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (792, 402, '005', 'GLÓBULOS BLANCOS:', 'cel/mm3', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (793, 402, '006', 'RECUENTO DIFERENCIAL:', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (794, 402, '007', 'MIELOCITOS:', '%', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (795, 402, '008', 'METAMIELOCITOS:', '%', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (796, 402, '009', 'BASÓFILOS:', '%', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (797, 402, '010', 'EOSINÓFILOS:', '%', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (798, 402, '011', 'CAYADOS:', '%', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (799, 402, '012', 'SEGMENTADOS NEUTRÓFILOS:', '%', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (800, 402, '013', 'LINFOCITOS:', '%', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (801, 402, '014', '', '', NULL, 'E', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (802, 403, '001', 'CONTAJE GLÓBULOS BLANCOS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (803, 403, '002', 'EN LÍQUIDO PERITONEAL:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (804, 403, '003', 'GLÓBULOS BLANCOS:', 'cel/mm3', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (805, 403, '004', 'RECUENTO DIFERENCIAL:', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (806, 403, '008', 'EOSINÓFILOS:', '%', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (807, 403, '010', 'POLIMORFONUCLEARES', '%', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (808, 403, '011', 'MONONUCLEARES', '%', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (809, 403, '012', 'MONOCITOS:', '%', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (810, 403, '013', 'LINFOCITOS ATÍPICOS:', '%', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (811, 403, '014', 'OTROS:', '%', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (812, 403, '015', '', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (813, 404, '001', 'CORTISOL A.M.:', 'ug/dL', '5.0 - 25.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (814, 404, '002', 'CORTISOL P.M.:', 'ug/dL', '3.0 - 13.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (815, 322, '001', 'CREATININA EN LÍQUIDO:', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (816, 323, '001', 'CREATININA EN LÍQUIDO PERITONEAL:', 'mg/dL', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (817, 325, '001', 'CUERPOS CETÓNICOS EN ORINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (818, 325, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (819, 326, '001', 'CUERPOS CETÓNICOS EN SANGRE:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (820, 326, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (821, 327, '001', 'TIPO DE MUESTRA:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (822, 327, '002', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (823, 327, '003', '.', '', NULL, 'E', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (824, 327, '004', 'OBSERVACIÓN:', '', NULL, 'O', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (825, 327, '005', 'GERMEN AISLADO:', '', NULL, 'O', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (826, 327, '006', 'ANTIBIOGRAMA:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (827, 327, '007', 'SENSIBLE:', '', NULL, 'O', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (828, 324, '001', 'Cryptosporidium:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (829, 324, '002', 'Giardia:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (830, 324, '003', 'Entamoeba hystolitica:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (831, 405, '001', 'DENSIDAD EN LÍQUIDO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (832, 405, '002', 'RESULTADO:', 'g/mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (833, 406, '001', 'DET. HCG EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (834, 406, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (835, 407, '001', 'DET. HCG EN SANGRE', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (836, 328, '001', 'DI HIDRO TESTOSTERONA:', 'pg/mL', '10.0 - 181.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (837, 329, '001', 'DIMERO D:', 'mg/L', '< 0.5', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (838, 330, '001', 'DREPANOCITOS:', '', NULL, 'O', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (839, 330, '002', '', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (840, 331, '001', 'SODIO:', 'mEq/L', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (841, 331, '002', 'POTASIO:', 'mEq/L', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (842, 331, '003', 'CLORO:', 'mEq/L', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (843, 332, '001', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (844, 335, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (845, 335, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (846, 335, '003', 'ASPECTO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (847, 335, '004', 'COLOR:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (848, 335, '005', 'pH:', '', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (849, 335, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (850, 335, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (851, 335, '008', 'CANTIDAD:', 'c.c.', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (852, 335, '009', 'ASPECTO:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (853, 335, '010', 'COLOR:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (854, 335, '011', 'PROTEINAS TOTALES:', 'g/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (855, 335, '012', 'GLUCOSA:', 'mg/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (856, 335, '013', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (857, 335, '014', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (858, 335, '015', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (859, 335, '016', 'POLIMORFONUCLEARES', '%', NULL, 'N', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (860, 334, '001', 'EDAD:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (861, 334, '002', 'SEXO:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (862, 334, '003', 'REFERIDO POR EL DOCTOR:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (863, 334, '004', 'ANÁLISIS CUALITATIVO CÁLCULO:', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (864, 334, '005', 'ANÁLISIS FÍSICO', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (865, 334, '006', 'FORMA DE PRESENTACIÓN:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (866, 334, '007', 'MORFOLOGÍA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (867, 334, '008', 'COLOR:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (868, 334, '009', 'CONSISTENCIA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (869, 334, '010', 'TEXTURA:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (870, 334, '011', 'PESO:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (871, 334, '012', 'MEDIDAS:', '', NULL, 'T', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (872, 334, '013', 'ANÁLISIS QUÍMICO:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (873, 334, '014', 'COMPOSICIÓN:', '', NULL, 'O', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (874, 334, '015', '', '', NULL, 'E', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (875, 334, '016', '', '', NULL, 'E', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (876, 336, '001', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (877, 338, '001', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (878, 339, '001', 'H.C.G. BETA CUANTITATIVA:', 'mUI/mL', '15000.0 - 200000.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (879, 340, '001', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (880, 340, '002', 'ASPECTO:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (881, 340, '003', 'CONSISTENCIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (882, 340, '004', 'REACCIÓN:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (883, 340, '005', 'MOCO:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (884, 340, '006', 'SANGRE:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (885, 340, '007', 'EXAMEN MICROSCÓPICO', '', NULL, 'E', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (886, 340, '008', 'FLORA BACTERIANA:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (887, 340, '009', 'LEUCOCITOS:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (888, 340, '010', 'HEMATÍES:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (889, 340, '011', 'LEVADURAS:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (890, 340, '012', 'PARÁSITOS Y SUS FORMAS:', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (891, 340, '013', 'MÉTODOS UTILIZADOS', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (892, 340, '014', 'DIRECTO Y CONCENTRADO (KATO):', '', NULL, 'T', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (893, 340, '015', 'DIRECTO (SOL. SALINA Y LUGOL):', '', NULL, 'T', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (894, 340, '016', 'AZUL DE METILENO:', '', NULL, 'O', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (895, 340, '017', 'COLOR:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (896, 341, '001', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (897, 341, '002', 'ASPECTO:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (898, 341, '003', 'COLOR:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (899, 341, '004', 'CONSISTENCIA:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (900, 341, '005', 'REACCIÓN:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (901, 341, '006', 'MOCO:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (902, 341, '007', 'SANGRE:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (903, 341, '008', 'EXAMEN MICROSCÓPICO', '', NULL, 'E', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (904, 341, '009', 'FLORA BACTERIANA:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (905, 341, '010', 'LEUCOCITOS:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (906, 341, '011', 'HEMATÍES:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (907, 341, '012', 'LEVADURAS:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (908, 341, '013', 'PARÁSITOS Y SUS FORMAS:', '', NULL, 'O', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (909, 341, '014', 'MÉTODOS UTILIZADOS:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (910, 341, '015', 'DIRECTO Y CONCENTRADO (KATO):', '', NULL, 'T', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (911, 341, '016', 'DIRECTO (SOL. SALINA Y LUGOL):', '', NULL, 'T', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (912, 341, '017', 'AZUL DE METILENO:', '', NULL, 'O', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (913, 345, '001', 'IgM Chlamydia Pneumoniae:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (914, 345, '002', 'IgG Chlamydia Pneumoniae:', 'UI/mL', '> 1.1', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (915, 357, '001', 'IgA Chlamydia trachomatis:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (916, 346, '001', 'IgM Chlamydia trachomatis:', 'UI/mL', '> 1.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (917, 346, '002', 'IgG Chlamydia trachomatis:', 'UI/mL', '> 1.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (918, 347, '001', 'IgM CMV:', 'UI/mL', '> 1.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (919, 347, '002', 'IgG CMV:', 'UI/mL', '> 1.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (920, 344, '001', 'IgG DE CARDIOLIPINAS:', 'UI/mL', '> 12.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (921, 344, '002', 'IgM DE CARDIOLIPINAS:', 'UI/mL', '> 12.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (922, 343, '001', 'IgM HERPES:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (923, 343, '002', 'IgG HERPES:', 'UI/mL', '> 1.1', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (924, 348, '001', 'IgM Mycoplasma pneumoniae:', 'UI/mL', '> 1.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (925, 348, '002', 'IgG Mycoplasma pneumoniae:', 'UI/mL', '> 1.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (926, 349, '001', 'IgM RUBEOLA:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (927, 349, '002', 'IgG RUBEOLA:', 'UI/mL', '> 2.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (928, 349, '003', 'MÉTODO UTILIZADO: ELISA', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (929, 354, '001', 'IgG PAROTIDITIS:', 'UI/mL', '> 8.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (930, 355, '001', 'IgM PAROTIDITIS:', 'UI/mL', '> 8.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (931, 356, '001', 'IgM PAROTIDITIS:', 'UI/mL', '> 8.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (932, 356, '002', 'IgG PAROTIDITIS:', 'UI/mL', '> 8.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (933, 350, '001', 'IgM Epstein barr:', 'UI/mL', '> 1.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (934, 350, '002', 'IgG Epstein barr:', 'UI/mL', '> 1.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (935, 358, '001', 'V.C.M.:', 'um3', '80.0 - 110.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (936, 358, '002', 'H.C.M.:', 'pg', '27.0 - 31.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (937, 358, '003', 'C.H.C.M.:', 'g/dL', '32.0 - 35.0', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (938, 359, '001', 'INFLUENZA A:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (939, 359, '002', 'INFLUENZA B:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (940, 359, '003', '', '', NULL, 'E', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (941, 364, '001', 'Streptococcus agalactiae:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (942, 364, '002', 'Streptococcus pneumoniae:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (943, 364, '003', 'Haemophilus influenzae Tipo B:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (944, 364, '004', 'Neisseria meningitidis:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (945, 364, '005', '(Grupo: A, B, C, Y, W135):', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (946, 363, '001', 'Streptococcus agalactiae:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (947, 363, '002', 'Streptococcus pneumoniae:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (948, 363, '003', 'Haemophilus influenzae Tipo B:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (949, 363, '004', 'Neisseria meningitidis:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (950, 363, '005', '(Grupo A, B, C, Y, W135):', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (951, 365, '001', 'INVESTIGACIÓN DE', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (952, 365, '002', 'Cryptosporidium sp:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (953, 365, '003', '.', '', NULL, 'O', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (954, 365, '005', '', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (955, 365, '006', '', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (956, 371, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (957, 371, '002', 'LÍQUIDO ARTICULAR', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (958, 371, '003', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (959, 371, '004', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (960, 371, '005', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (961, 371, '006', 'DESPUÉS DE CENTRIFUGAR', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (962, 371, '007', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (963, 371, '008', 'ASPECTO:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (964, 371, '009', 'COLOR:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (965, 371, '010', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (966, 371, '011', 'DENSIDAD:', 'g/mL', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (967, 371, '012', 'pH:', '', NULL, 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (968, 371, '013', 'PROTEÍNAS TOTALES:', 'g%', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (969, 371, '014', 'GLUCOSA:', 'mg%', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (970, 371, '015', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (971, 371, '016', 'CÉLULAS:', '', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (972, 371, '017', 'LINFOCITOS:', '%', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (973, 371, '018', 'SEGMENTADOS NEUTRÓFILOS:', '%', NULL, 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (974, 371, '019', '', '', NULL, 'E', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (975, 372, '001', 'LÍQUIDO ASCÍTICO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (976, 372, '002', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (977, 372, '003', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (978, 372, '004', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (979, 372, '005', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (980, 372, '006', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (981, 372, '007', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (982, 372, '008', 'ASPECTO:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (983, 372, '009', 'COLOR:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (984, 372, '010', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (985, 372, '011', 'ALBÚMINA:', 'g%', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (986, 372, '012', 'GLOBULINA:', 'g%', NULL, 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (987, 372, '013', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (988, 372, '014', 'GLUCOSA:', 'mg/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (989, 372, '015', 'DENSIDAD:', 'mg/L', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (990, 372, '016', 'pH:', '', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (991, 372, '017', 'L.D.H.:', '', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (992, 372, '018', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (993, 372, '019', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (994, 373, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (995, 373, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (996, 373, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (997, 373, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (998, 373, '005', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (999, 373, '006', 'CANTIDAD:', 'c.c.', NULL, 'N', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1000, 373, '007', 'ASPECTO:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1001, 373, '008', 'COLOR:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1002, 373, '009', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1003, 373, '010', 'GLUCORRAQUIA:', 'mg/dL', '50.0 - 100.0', 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1004, 373, '011', 'PROTEÍNAS TOTALES.', 'mg/dL', '15.0 - 45.0', 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1005, 373, '013', 'CLORUROS:', 'mEq/L', '120.0 - 130.0', 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1006, 373, '014', 'POLIMORFONUCLEARES', '%', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1007, 373, '015', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1008, 373, '016', 'HEMATIES', '', NULL, 'T', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1009, 373, '017', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1010, 374, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1011, 374, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1012, 374, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1013, 374, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1014, 374, '005', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1015, 374, '006', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1016, 374, '007', 'ASPECTO:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1017, 374, '008', 'COLOR:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1018, 374, '009', 'NOTA:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1019, 374, '010', 'BOTÓN DE HEMATÍES EN EL FONDO DEL TUBO:', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1020, 374, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1021, 374, '012', 'CREATININA:', 'mg%', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1022, 374, '013', 'ALBÚMINA:', 'g%', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1023, 374, '014', 'GLICEMIA:', 'mg%', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1024, 374, '015', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1025, 374, '016', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1026, 374, '017', 'DENSIDAD:', 'mg/c.c.', NULL, 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1027, 374, '018', 'pH:', '', NULL, 'N', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1028, 375, '001', 'CARACTERÍSTICAS FÍSICAS:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1029, 375, '002', 'COLOR:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1030, 375, '003', 'ASPECTO:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1031, 375, '004', 'VOLUMEN:', 'mL', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1032, 375, '005', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1033, 375, '006', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1034, 375, '007', 'COLOR:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1035, 375, '008', 'ASPECTO:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1036, 375, '009', 'VOLUMEN:', 'mL', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1037, 375, '010', 'ANÁLISIS QUÍMICO:', '', NULL, 'E', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1038, 375, '011', 'GLUCOSA:', 'mg/dL', NULL, 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1039, 375, '012', 'PROTEÍNAS:', 'g/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1040, 375, '013', 'pH:', '', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1041, 375, '014', 'DENSIDAD:', 'g/mL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1042, 375, '015', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1043, 375, '016', 'RECUENTO DIFERENCIAL:', '', NULL, 'O', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1044, 375, '017', '', '', NULL, 'O', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1045, 375, '018', 'OTROS:', '', NULL, 'O', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1046, 376, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1047, 376, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1048, 376, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1049, 376, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1050, 376, '005', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1051, 376, '006', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1052, 376, '007', 'ASPECTO:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1053, 376, '008', 'COLOR:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1054, 376, '009', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1055, 376, '010', 'PROTEÍNAS TOTALES:', 'mg/dL', '15.0 - 45.0', 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1056, 376, '011', 'GLUCOSA:', 'mg/dL', '50.0 - 80.0', 'N', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1057, 376, '012', 'CLORUROS:', 'mEq/dL', '120.0 - 130.0', 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1058, 376, '013', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1059, 376, '014', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1060, 377, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1061, 377, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1062, 377, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1063, 377, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1064, 377, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1065, 377, '006', 'DENSIDAD:', 'g/c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1066, 377, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1067, 377, '008', 'NOTA: BOTÓN DE HEMATÍES EN EL FONDO DEL TUBO', '', NULL, 'E', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1068, 377, '009', 'CANTIDAD:', 'c.c.', NULL, 'N', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1069, 377, '010', 'ASPECTO:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1070, 377, '011', 'COLOR:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1071, 377, '012', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1072, 377, '013', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1073, 377, '014', 'GLUCORRAQUIA:', 'mg/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1074, 377, '015', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1075, 377, '016', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1076, 378, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1077, 378, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1078, 378, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1079, 378, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1080, 378, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1081, 378, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1082, 378, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1083, 378, '008', 'CANTIDAD:', 'c.c.', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1084, 378, '009', 'ASPECTO:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1085, 378, '010', 'COLOR:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1086, 378, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1087, 378, '012', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1088, 378, '013', 'GLUCOSA:', 'mg/dL', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1089, 378, '015', 'AMILASA:', 'UI/L', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1090, 379, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1091, 379, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1092, 379, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1093, 379, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1094, 379, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1095, 379, '006', 'DENSIDAD:', 'g/c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1096, 379, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1097, 379, '008', 'CANTIDAD:', 'c.c.', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1098, 379, '009', 'ASPECTO:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1099, 379, '010', 'COLOR:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1100, 379, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1101, 379, '012', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1102, 379, '013', 'GLUCOSA:', 'mg/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1103, 379, '014', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1104, 379, '015', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1105, 380, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1106, 380, '002', 'COLOR:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1107, 380, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1108, 380, '004', 'VOLUMEN:', 'mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1109, 380, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1110, 380, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1111, 380, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1112, 380, '008', 'ASPECTO:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1113, 380, '009', 'COLOR:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1114, 380, '010', 'VOLUMEN:', 'mL', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1115, 380, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1116, 380, '012', 'GLUCOSA:', 'mg/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1117, 380, '013', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1118, 380, '014', 'CREATININA:', 'mg/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1119, 380, '015', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1120, 380, '016', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1121, 381, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1122, 381, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1123, 381, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1124, 381, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1125, 381, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1126, 381, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1127, 381, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1128, 381, '008', 'NOTA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1129, 381, '009', '', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1130, 381, '010', 'CANTIDAD:', 'c.c.', NULL, 'N', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1131, 381, '011', 'ASPECTO:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1132, 381, '012', 'COLOR:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1133, 381, '013', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1134, 381, '014', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1135, 381, '015', 'GLUCOSA:', 'mg/dL', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1136, 381, '016', 'ALBÚMINA:', 'g/dL', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1137, 381, '017', 'GLOBULINA:', 'g/dL', NULL, 'N', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1138, 381, '018', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1139, 381, '019', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1140, 383, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1141, 383, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1142, 383, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1143, 383, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1144, 383, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1145, 383, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1146, 383, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1147, 383, '008', 'CANTIDAD:', 'c.c.', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1148, 383, '009', 'ASPECTO:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1149, 383, '010', 'COLOR:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1150, 383, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1151, 383, '012', 'PROTEÍNAS TOTALES:', 'mg/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1152, 383, '013', 'GLUCORRAQUIA:', 'mg/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1153, 383, '014', 'CLORUROS:', 'mEq/L', NULL, 'N', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1154, 383, '015', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1155, 383, '016', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1156, 382, '001', 'ANTES DE CENTRIFUGAR:', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1157, 382, '002', 'CANTIDAD:', 'c.c.', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1158, 382, '003', 'ASPECTO:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1159, 382, '004', 'COLOR:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1160, 382, '005', 'pH:', '', NULL, 'N', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1161, 382, '006', 'DENSIDAD:', 'g/mL', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1162, 382, '007', 'DESPUÉS DE CENTRIFUGAR:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1163, 382, '008', 'CANTIDAD:', 'c.c.', NULL, 'N', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1164, 382, '009', 'ASPECTO:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1165, 382, '010', 'COLOR:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1166, 382, '011', 'ESTUDIO QUÍMICO:', '', NULL, 'E', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1167, 382, '012', 'PROTEÍNAS TOTALES:', 'g/dL', NULL, 'N', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1168, 382, '013', 'GLUCOSA:', 'mg/dL', NULL, 'N', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1169, 382, '014', 'ESTUDIO MICROSCÓPICO:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1170, 382, '015', 'CÉLULAS:', 'cel/mm3', NULL, 'N', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1171, 385, '001', 'MICROALBUMINURIA EN ORINA PARCIAL:', 'mg/L', '> 25.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1172, 386, '001', 'RESULTADO:', 'ng/mL', '> 12.5', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1173, 387, '001', 'PERFIL VIRAL RESPIRATORIO', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1174, 387, '002', 'MUESTRA: MOCO NASAL', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1175, 387, '003', '', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1176, 387, '004', 'ADENOVIRUS:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1177, 387, '005', 'INFLUENZA A-B:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1178, 387, '006', 'VIRUS SINCITIAL RESPIRATORIO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1179, 390, '001', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1180, 390, '002', 'CONTROL:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1181, 390, '003', 'MEZCLA:', 's', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1182, 390, '004', 'DELTA:', 's', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1183, 388, '001', 'CONTROL:', 's', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1184, 388, '002', 'MEZCLA:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1185, 388, '003', 'RESULTADO MEZ/CONTROL:', '', NULL, 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1186, 389, '001', 'P.T./INR', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1187, 389, '002', 'CONTROL:', 's', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1188, 389, '003', 'PACIENTE:', 's', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1189, 389, '004', 'RELACIÓN PACIENTE/CONTROL:', '', '0.8 - 1.2', 'F', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1190, 389, '005', 'ISI:', '', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1191, 389, '006', 'I.N.R.:', '', NULL, 'F', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1192, 392, '001', 'IgG SARAMPIÓN:', 'UI/mL', '0.9 - 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1193, 391, '001', 'IgM SARAMPIÓN:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1194, 391, '002', 'IgG SARAMPIÓN:', 'UI/mL', '> 1.1', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1195, 393, '001', 'IgM SARAMPIÓN:', 'UI/mL', '> 12.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1196, 408, '001', 'SANGRE OCULTA EN CONTENIDO GÁSTRICO:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1197, 408, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1198, 395, '001', 'TINTA CHINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1199, 399, '001', 'UREA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1200, 399, '002', '', '', NULL, 'E', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1201, 399, '003', 'CREATININA:', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1202, 409, '001', 'IgM:', 'UI/mL', '> 1.1', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1203, 409, '002', 'IgG:', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1204, 410, '001', 'VIRUS SINCITIAL EN MOCO NASAL:', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1205, 400, '001', '25 HIDROXI VITAMINA D:', 'ng/mL', '30.0 - 100.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1206, 214, '004', 'ÁCIDO ÚRICO EN ORINA DE 1 HORA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1207, 411, '001', 'IgM ANTI FOSFOLÍPIDOS:', 'UI/mL', '> 18.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1208, 411, '002', 'IgG ANTI FOSFOLÍPIDOS:', 'UI/mL', '> 18.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1209, 133, '002', 'Salmonella Typhi O.:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1210, 133, '003', 'Salmonella Typhi H.:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1211, 133, '004', 'Salmonella H Paratyphi a:', '', NULL, 'T', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1212, 133, '005', 'Salmonella H Paratyphi b:', '', NULL, 'T', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1213, 133, '006', 'PROTEUS OX-19:', '', NULL, 'T', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1214, 133, '007', 'Brucella Abortus:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1215, 412, '001', 'IgM B2 GLICOPROTEINAS:', 'UI/mL', '> 12.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1216, 412, '002', 'IgG B2 GLICOPROTEINAS:', 'UI/mL', '> 12.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1217, 85, '023', 'TIPO DE MUESTRA:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1218, 303, '001', 'GASES ARTERIALES:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1219, 205, '001', 'GLICEMIA:', 'mg/dL', '70.0 - 110.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1220, 277, '001', 'GLICEMIA BASAL:', 'mg/dL', '70.0 - 110.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1221, 277, '002', 'GLICEMIA POSTPRANDIAL:', 'mg/dL', '< 140.0', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1222, 276, '001', 'GLICEMIA POSTCARGA A LOS 60 MINUTOS:', 'mg/dL', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1223, 74, '002', 'CARGA GLUCOSA:', 'g', NULL, 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1224, 276, '002', 'CARGA GLUCOSA:', 'grs', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1225, 384, '001', 'MICROALBUMINURIA:', 'mg/24h', '5.0 - 30.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1226, 384, '002', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1227, 401, '001', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1228, 401, '002', 'COLOR:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1229, 401, '003', 'pH:', '', '4.5 - 7.5', 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1230, 401, '004', 'DENSIDAD:', 'g/mL', '1018.0 - 1030.0', 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1231, 401, '005', 'ASPECTO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1232, 401, '007', 'EXAMEN QUÍMICO', '', NULL, 'E', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1233, 401, '008', 'HEMOGLOBINA:', '', NULL, 'T', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1234, 401, '009', 'PROTEÍNAS:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1235, 401, '010', 'GLUCOSA:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1236, 401, '011', 'CUERPOS CETÓNICOS:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1237, 401, '012', 'UROBILINÓGENO:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1238, 401, '013', 'NITRITOS:', '', NULL, 'T', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1239, 401, '014', 'ESTUDIO DE SEDIMENTO', '', NULL, 'E', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1240, 401, '015', 'LEUCOCITOS:', '', NULL, 'T', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1241, 401, '016', 'HEMATÍES:', '', NULL, 'T', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1242, 401, '017', 'CÉLULAS EPITELIALES PLANAS:', '', NULL, 'T', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1243, 401, '018', 'BACTERIAS:', '', NULL, 'T', 21, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1244, 401, '019', 'FILAMENTOS DE MUCINA:', '', NULL, 'T', 22, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1245, 413, '001', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1246, 413, '002', 'COLOR:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1247, 413, '003', 'pH:', '', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1248, 413, '004', 'DENSIDAD:', 'g/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1249, 413, '005', 'ASPECTO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1250, 413, '006', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1251, 413, '007', 'EXAMEN QUÍMICO', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1252, 413, '008', 'HEMOGLOBINA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1253, 413, '009', 'PROTEÍNAS:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1254, 413, '010', 'GLUCOSA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1255, 413, '011', 'CUERPOS CETÓNICOS:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1256, 413, '012', 'UROBILINÓGENO:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1257, 413, '013', 'NITRITOS:', '', NULL, 'T', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1258, 413, '014', 'ESTUDIO DE SEDIMENTO:', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1259, 413, '015', 'LEUCOCITOS:', '', NULL, 'T', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1260, 413, '016', 'HEMATÍES:', '', NULL, 'T', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1261, 413, '017', 'CÉLULAS EPITELIALES PLANAS:', '', NULL, 'T', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1262, 413, '018', 'BACTERIAS:', '', NULL, 'T', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1263, 413, '019', 'FILAMENTOS DE MUCINA:', '', NULL, 'T', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1264, 414, '001', 'EXAMEN FÍSICO', '', NULL, 'E', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1265, 414, '002', 'COLOR:', '', NULL, 'T', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1266, 414, '003', 'pH:', '', NULL, 'N', 4, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1267, 414, '004', 'DENSIDAD:', 'g/mL', NULL, 'N', 5, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1268, 414, '005', 'ASPECTO:', '', NULL, 'T', 6, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1269, 414, '006', 'CANTIDAD:', 'c.c.', NULL, 'N', 7, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1270, 414, '007', 'EXAMEN QUÍMICO:', '', NULL, 'E', 8, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1271, 414, '008', 'HEMOGLOBINA:', '', NULL, 'T', 9, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1272, 414, '009', 'PROTEÍNAS:', '', NULL, 'T', 10, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1273, 414, '010', 'GLUCOSA:', '', NULL, 'T', 11, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1274, 414, '011', 'CUERPOS CETÓNICOS:', '', NULL, 'T', 12, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1275, 414, '012', 'UROBILINÓGENOS:', '', NULL, 'T', 13, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1276, 414, '013', 'NITRITOS:', '', NULL, 'T', 14, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1277, 414, '014', 'ESTUDIO DE SEDIMENTO', '', NULL, 'E', 15, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1278, 414, '015', 'LEUCOCITOS:', '', NULL, 'T', 16, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1279, 414, '016', 'HEMATÍES:', '', NULL, 'T', 17, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1280, 414, '017', 'CÉLULAS EPITELIALES PLANAS:', '', NULL, 'T', 18, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1281, 414, '018', 'BACTERIAS:', '', NULL, 'T', 19, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1282, 414, '019', 'FILAMENTOS DE MUCINA:', '', NULL, 'T', 20, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1283, 241, '001', 'OXALATO EN ORINA PARCIAL:', 'mg/dL', NULL, 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1284, 415, '001', 'TESTOSTERONA TOTAL:', 'ng/dL', '0.8 - 0.35', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1285, 415, '002', 'TESTOSTERONA LIBRE:', 'pg/mL', '6.1 - 27.9', 'N', 3, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1286, 204, '001', 'TRANSFERRINA:', 'Ug/mL', '250.0 - 400.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1287, 255, '005', 'RELACIÓN ÁCIDO ÚRICO/CREATININA EN 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1288, 254, '005', 'RELACIÓN ÁCIDO ÚRICO/CREATININA EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1289, 256, '004', 'RELACIÓN ALBÚMINA/CREATININA EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1290, 183, '004', 'RELACIÓN CALCIO/CREATININA EN ORINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1291, 251, '005', 'RELACIÓN CALCIO/CREATININA EN ORINA DE 24H', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1292, 252, '004', 'REL. CALCIO/CREATININA EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1293, 257, '004', 'RELACIÓN CITRATO/CREATININA EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1294, 282, '004', 'RELACIÓN CITRATO/CREATININA EN ORINA DE 24H', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1295, 258, '005', 'RELACIÓN FÓSFORO/CREATININA EN ORINA DE 24H', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1296, 259, '004', 'RELACIÓN MAGNESIO/CREATININA EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1297, 260, '004', 'RELACIÓN OXALATO/CREATININA EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1298, 126, '002', 'A.S.L.O.:', 'UI/mL', '> 200.0', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1299, 416, '001', 'A.C.T.H.:', 'pg/mL', '7.9 - 66.1', 'N', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1300, 417, '001', 'ANTICUERPOS ANTITIROGLOBULINA:', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1301, 418, '001', 'C.P.K. FOSFO-QUINASA CREATINA:', 'UI/L', '30.0 - 170.0', 'N', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1302, 419, '001', 'Helicobacter pylori EN HECES', '', NULL, 'T', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1303, 344, '003', 'ANTI CARDIOLIPINAS', '', NULL, 'E', 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1304, 335, '017', 'TIPO DE MUESTRA:', '', NULL, 'T', 2, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exam_items` VALUES (1305, 335, '018', 'ESTUDIO FÍSICO:', '', NULL, 'E', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1306, 32, '001', 'AMILASA:', 'U/I', '< 100.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1307, 334, '017', 'FECHA DE REALIZACIÓN:', '', NULL, 'T', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1308, 358, '004', 'ÍNDICES HEMATIMÉTRICOS:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1309, 216, '003', 'ÁCIDO ÚRICO EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1310, 213, '002', 'ALBÚMINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1311, 411, '003', 'ANTI FOSFOLÍPIDOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1312, 412, '003', 'B2 GLICOPROTEÍNAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1313, 345, '003', 'Chlamydia pneumoniae', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1314, 346, '003', 'Chlamydia trachomatis', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1315, 347, '003', 'CITOMEGALOVIRUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1316, 404, '003', 'CORTISOL A.M. - P.M.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1317, 189, '011', 'CURVA GLUCOSA 0, 60, 120, 240 MIN', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1318, 95, '006', 'DEPURACIÓN DE UREA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1319, 331, '004', 'ELECTROLITOS EN AGUA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1320, 332, '002', 'EOSINÓFILOS EN MOCO NASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1321, 350, '003', 'Epstein Barr', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1322, 334, '018', 'ESTUDIO CÁLCULO URINARIO:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1323, 335, '019', 'ESTUDIO DE LÍQUIDO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1324, 336, '002', 'ESTUDIO DIRECTO PARA ECTOPARÁSITOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1325, 299, '006', 'EXCRECIÓN FRACCIONADA DE CALCIO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1326, 300, '006', 'EXCRECIÓN FRACCIONADA DE FOSFATO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1327, 301, '006', 'EXCRECIÓN FRACCIONADA DE POTASIO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1328, 302, '006', 'EXCRECIÓN FRACCIONADA DE SODIO - FENA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1329, 298, '006', 'EXCRECIÓN FRACCIONADA DE ÁCIDO ÚRICO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1330, 83, '003', 'GRUPO SANGUÍNEO Y FACTOR RH', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1331, 41, '038', 'HECES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1332, 340, '018', 'HECES (II)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1333, 341, '018', 'HECES (III)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1334, 307, '003', 'HEMOGLOBINA - HEMATOCRITO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1335, 343, '003', 'HERPES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1336, 89, '002', 'INSULINA BASAL, 60 Y 120 MINUTOS:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1337, 280, '003', 'INSULINA BASAL Y POSTPRANDIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1338, 74, '003', 'INSULINA POSTCARGA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1339, 112, '002', 'INSULINA POSTPRANDIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1340, 373, '018', 'LÍQUIDO CEFALORRAQUÍDEO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1341, 374, '019', 'LÍQUIDO DE OSTOMÍA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1342, 375, '019', 'LÍQUIDO DE PUNCIÓN RENAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1343, 376, '015', 'LÍQUIDO DE SECRECIÓN NASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1344, 377, '017', 'LÍQUIDO PERICÁRDICO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1345, 378, '018', 'LÍQUIDO PERITONEAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1346, 379, '016', 'LÍQUIDO PLEURAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1347, 380, '017', 'LÍQUIDO DE SECRECIÓN DE HERIDA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1348, 381, '020', 'LÍQUIDO SINOVIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1349, 382, '016', 'LÍQUIDO SUBDURAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1350, 383, '017', 'LÍQUIDO TUMOR REGIÓN CELLAR', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1351, 281, '003', 'MAGNESIO EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1352, 348, '003', 'Mycoplasma pneumoniae', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1353, 401, '020', 'ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1354, 413, '020', 'ORINA (II)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1355, 414, '020', 'ORINA (III)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1356, 17, '005', 'TIEMPO DE PROTROMBINA (P.T.)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1357, 388, '004', 'P.T. CORREGIDO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1358, 107, '006', 'TIEMPO PARCIAL DE TROMBOPLASTINA (P.T.T.)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1359, 390, '005', 'P.T.T. CORREGIDO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1360, 356, '003', 'PAROTIDITIS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1361, 308, '033', 'PERFIL DE LITIASIS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1362, 162, '002', 'PLOMO EN SANGRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1363, 242, '003', 'PROTEINURIA EN ORINA DE 12 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1364, 243, '003', 'PROTEINURIA EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1365, 246, '006', 'REABSORCIÓN TUBULAR DE POTASIO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1366, 245, '006', 'REABSORCIÓN TUBULAR DE FOSFATO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1367, 253, '006', 'REL. ÁC. ÚRICO/CREATININA EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1368, 349, '004', 'RUBEOLA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1369, 391, '003', 'SARAMPIÓN', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1370, 310, '004', 'TIEMPO DE TROMBINA (T.T.)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1371, 415, '003', 'TESTOSTERONA TOTAL Y LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1372, 174, '002', '%  SATURACIÓN DE LA TRANSFERINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1373, 114, '002', '17 OH PROGESTERONA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1374, 416, '002', 'A.C.T.H.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1375, 313, '011', 'A.N.A. (BLOT)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1376, 118, '001', 'ACIDO FÓLICO (FOLATO):', 'ng/mL', '> 4.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1377, 125, '002', 'ÁCIDO LÁCTICO (LACTATO)', 'mg/dL', '4.5 - 19.8', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1378, 217, '002', 'ÁCIDO ÚRICO EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1379, 285, '002', 'ÁCIDO ÚRICO NO DISOCIADO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1380, 62, '002', 'ÁCIDO VALPROICO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1381, 176, '004', 'ADENOVIRUS - ROTAVIRUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1382, 314, '002', 'ADENOVIRUS EN MOCO NASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1383, 294, '002', 'ALBÚMINA EN LÍQUIDO PERITONEAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1384, 218, '002', 'ALBÚMINA EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1385, 219, '003', 'ALBUMINURIA EN 12 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1386, 220, '003', 'ALBUMINURIA EN 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1387, 127, '002', 'ALDOLASA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1388, 60, '002', 'ALFA FETOPROTEÍNAS (A.F.P.)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1389, 283, '002', 'AMILASA EN LÍQUIDO ABDOMINAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1390, 284, '002', 'AMILASA EN LÍQUIDO PERITONEAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1391, 128, '002', 'AMILASA EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1392, 178, '002', 'ANDROSTENODIONA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1393, 209, '003', 'ANTI BETA 2 GLICOPROTEÍNA IgG', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1394, 315, '004', 'ANTIGENO CONTRA Ag.e HB', '', NULL, 'E', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1395, 199, '002', 'ANTI HBsAg (ANTÍGENO DE SUPERFICIE):', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1396, 292, '004', 'B.K. EN ORINA - SERIADO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1397, 139, '002', 'C1 INHIBIDOR', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1398, 36, '002', 'COMPLEMENTO C3', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1399, 102, '002', 'COMPLEMENTO C4', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1400, 58, '002', 'CA 125', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1401, 55, '003', 'CA 15.3', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1402, 56, '002', 'CA 19.9', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1403, 72, '002', 'CA 21.1', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1404, 57, '002', 'CA 72.4', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1405, 144, '002', 'CALCIO EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1406, 229, '003', 'CALCIO EN ORINA DE 12 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1407, 228, '003', 'CALCIO EN ORINA DE 2 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1409, 230, '002', 'CALCIO EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1410, 37, '003', 'CH 50', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1411, 231, '003', 'CITRATO EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1412, 232, '002', 'CITRATO EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1413, 201, '002', 'COLESTEROL V.L.D.L.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1414, 210, '008', 'CONTAJE BLANCO Y FÓRMULA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1415, 81, '012', 'COPROCULTIVO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1416, 208, '002', 'CORE B', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1417, 322, '002', 'CREATININA EN LÍQUIDO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1418, 322, '003', 'MUESTRA:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1419, 234, '003', 'CREATININA EN ORINA DE 12 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1420, 233, '003', 'CREATININA EN ORINA DE 2 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1421, 235, '003', 'CREATININA EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1422, 149, '002', 'CREATININA EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1423, 236, '002', 'CREATININA EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1424, 324, '004', 'Cryptosporidium / Giardia / Entamoeba h.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1425, 327, '008', 'CULTIVO HONGOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1426, 150, '002', 'CYFRA 21-1', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1427, 151, '002', 'DENSIDAD URINARIA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1428, 50, '002', 'ESTRADIOL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1429, 124, '011', 'EXUDADO FARÍNGEO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1430, 18, '002', 'FIBRINÓGENO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1431, 25, '002', 'FOSFATASA ÁCIDA-PROSTÁTICA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1432, 24, '002', 'FOSFATASA ALCALINA', 'U/L', '75.0 - 390.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1433, 248, '003', 'FÓSFORO EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1434, 275, '003', 'FÓSFORO EN ORINA DE 2 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1435, 164, '002', 'FÓSFORO EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1436, 247, '002', 'FÓSFORO EN SEGUNDA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1437, 49, '002', 'F.S.H.', 'mIU/mL', '> 20.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1438, 277, '003', 'GLICEMIA BASAL - POSTPRANDIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1439, 78, '002', 'GLICEMIA POSTPRANDIAL 2 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1440, 304, '002', 'GLUCOSA EN LÍQUIDO CEFALORRAQUÍDEO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1441, 305, '002', 'GLUCOSA EN LÍQUIDO PERITONEAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1442, 167, '002', 'GLUCOSURIA BASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1443, 168, '002', 'GLUCOSURIA POSTPRANDIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1444, 338, '002', 'GOTA GRUESA (PALUDISMO)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1445, 306, '002', 'GRAM', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1446, 237, '003', 'GRAM DE ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1447, 339, '002', 'H.C.G. BETA CUANTITATIVA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1448, 71, '002', 'H.C.G. BETA CUANTITATIVA (EMBARAZO)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1449, 170, '002', 'HORMONA CRECIMIENTO POST ESTÍMULO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1450, 53, '002', 'HORMONA DE CRECIMIENTO BASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1451, 359, '004', 'INFLUENZA EN MOCO NASAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1452, 99, '002', 'INSULINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1453, 364, '006', 'INVESTIGACIÓN AGENTES CAPSULARES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1454, 363, '006', 'INVESTIGACIÓN AGENTES CAPSULARES EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1455, 48, '002', 'L.H.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1456, 238, '002', 'LIPASA EN ORINA DE 12 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1457, 159, '002', 'MAGNESIO EN ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1458, 240, '002', 'NITRÓGENO EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1459, 386, '002', 'NSE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1461, 101, '002', 'PROCALCITONINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1462, 51, '002', 'PROGESTERONA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1463, 68, '002', 'PROLACTINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1464, 140, '002', 'PROTEÍNAS DE BENCE JONES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1465, 141, '003', 'PROTEINURIA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1466, 142, '002', 'PARATHORMONA (PTH)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1467, 143, '002', 'RETRACCIÓN DEL COÁGULO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1468, 42, '002', 'SANGRE OCULTA EN HECES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1469, 65, '002', 'SUDAN III', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1470, 420, '001', 'T3 TOTAL Y LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1471, 420, '002', 'T3 TOTAL', 'nmol/L', '0.6 - 1.85', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1472, 420, '003', 'T3 LIBRE', 'pg/mL', '2.8 - 7.3', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1473, 421, '001', 'T4 TOTAL Y LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1474, 421, '002', 'T4 TOTAL', 'ug/dL', '4.8 - 11.6', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1475, 421, '003', 'T4 LIBRE', 'ug/dL', '8.5 - 22.5', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1476, 63, '002', 'T3 LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1477, 46, '002', 'T3 TOTAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1478, 47, '002', 'T4 LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1479, 69, '002', 'T4 TOTAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1480, 52, '002', 'TESTOSTERONA LIBRE', 'pg/mL', '0.5 - 3.4', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1481, 97, '002', 'TESTOSTERONA TOTAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1482, 182, '002', 'T.G.O.', 'U/L', '> 38.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1483, 177, '002', 'T.G.P.', 'U/L', '> 40.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1484, 77, '002', 'TIROGLOBULINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1485, 22, '002', 'TRIGLICÉRIDOS', 'mg/dL', '> 165.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1486, 76, '001', 'T.S.H.', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1487, 173, '002', 'UREA EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1488, 197, '002', 'UREA EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1489, 399, '004', 'UREA-CREATININA EN LÍQ. DE PORTO-VAC', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1490, 16, '002', 'V.S.G. SEDIMENTACIÓN GLOBULAR', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1491, 66, '003', 'VITAMINA B12', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1492, 400, '002', '25 HIDROXI VITAMINA D', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1493, 402, '015', 'CONTAJE BLANCO EN LÍQUIDO DE DIÁLISIS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1494, 161, '001', 'MORFOLOGÍA DE GLÓBULOS ROJOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1495, 161, '002', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1496, 422, '001', 'ADENOVIRUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1497, 422, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1498, 100, '004', 'ROTAVIRUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1499, 279, '017', 'HEMATOLOGIA COMPLETA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1500, 451, '001', 'SARS COVID-2 ANTIGENO CUANTIFICADO', '', '> 0.04', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1501, 285, '003', 'ACIDO URICO URINARIO:', 'G/24H', '0.25 - 0.75', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1502, 285, '004', 'pH', '', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1503, 429, '001', 'COVID 19 IgM / IgG', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1504, 429, '002', 'IgM:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1505, 429, '003', 'IgG:', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1506, 430, '001', 'COVID-19 ANTICUERPOS NEUTRALIZANTES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1507, 179, '001', 'ANTIGENO AUSTRALIA (AU)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1508, 179, '002', 'ESTUDIO:', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1509, 179, '003', 'RESULTADO:', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1510, 458, '001', 'HORMONA ANTIMULERIANA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1511, 458, '002', 'RESULTADO:', 'ng/mL', '0.046 - 2.06', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1512, 423, '001', 'V.P.H', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1513, 423, '002', 'RESULTADO:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1514, 152, '002', 'DHEA-SO4', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1515, 113, '002', 'HELICOBACTER PYLORI (IGM)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1516, 203, '002', 'ANTICUERPOS ANTINUCLEARES (ANA)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1517, 448, '001', 'ALDOSTERONA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1518, 448, '002', 'ALDOSTERONA:', 'pg/ml', '10.0 - 160.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1519, 308, '034', 'CREATININA (g/24 h)::', 'g/24 h', NULL, 'N', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1520, 308, '035', 'FOSFORO URINARIO (mg/dl)', 'mg/dl', NULL, 'N', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1521, 431, '001', 'PANEL DE ALIMENTOS INTERNACIONAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1522, 431, '002', 'PANEL DE ALIMENTOS', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1523, 432, '001', 'PANEL RESPIRATORIO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1524, 432, '002', 'PANEL RESPIRATORIO', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1525, 459, '001', 'PANEL CELIACO IgA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1526, 459, '002', 'PANEL CELIACO IgA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1527, 460, '001', 'PANEL CELIACO IgG', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1528, 460, '002', 'PANEL CELIACO IgG', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1529, 80, '011', '-', '', NULL, 'O', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1530, 80, '012', '-', '', NULL, 'O', 24, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1531, 456, '001', 'ELECTROFORESIS DE PROTEINAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1532, 456, '002', 'UNIDAD INTEGRACION (ALBUMINA):', 'g/dL', '3.3 - 5.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1533, 456, '003', 'UNIDAD INTEGRACION (ALFA 1):', 'g/dL', '0.2 - 0.4', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1534, 456, '004', 'UNIDAD INTEGRACION (ALFA 2):', 'g/dL', '0.6 - 1.0', 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1535, 456, '005', 'UNIDAD INTEGRACION (BETA):', 'g/dL', '0.6 - 1.2', 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1536, 456, '006', 'UNIDAD INTEGRACION (GAMMA):', 'g/dL', '0.7 - 1.3', 'N', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1537, 456, '007', 'UNIDAD INTEGRACION (TOTAL):', 'g/dL', '6.0 - 8.0', 'N', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1538, 456, '008', 'PROTEINAS TOTALES:', 'g/dL', '6.0 - 8.0', 'N', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1539, 456, '009', 'RELACION ALBUMINA/GLOBULINA:', '', NULL, 'N', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1540, 456, '010', 'VALORES RELATIVOS (ALBUMINA):', '%', NULL, 'N', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1541, 456, '011', 'VALORES RELATIVOS (ALFA 1):', '%', NULL, 'N', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1542, 456, '012', 'VALORES RELATIVOS (ALFA 2):', '%', NULL, 'N', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1543, 456, '013', 'VALORES RELATIVOS (BETA):', '%', NULL, 'N', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1544, 456, '014', 'VALORES RELATIVOS (GAMMA):', '%', NULL, 'N', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1545, 456, '015', 'VALORES RELATIVOS (TOTAL):', '%', NULL, 'N', 16, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1546, 456, '016', 'VALORES ABSOLUTOS (ALBUMINA):', 'g/dL', NULL, 'N', 17, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1547, 456, '017', 'VALORES ABSOLUTOS (ALFA 1):', 'g/dL', NULL, 'N', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1548, 456, '018', 'VALORES ABSOLUTOS (ALFA 2):', 'g/dL', NULL, 'N', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1549, 456, '019', 'VALORES ABSOLUTOS (BETA):', 'g/dL', NULL, 'N', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1550, 456, '020', 'VALORES ABSOLUTOS (GAMMA):', 'g/dL', NULL, 'N', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1551, 456, '021', 'VALORES ABSOLUTOS (TOTAL):', 'g/dL', NULL, 'N', 22, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1552, 456, '022', '-', '', NULL, 'E', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1553, 462, '001', 'T.I.B.C.:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1554, 462, '002', 'T.I.B.C.:', 'ug/dL', '250.0 - 450.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1555, 463, '002', 'INTERLUQUINA (IL-6):', 'pg/mL', '< 10.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1556, 464, '001', 'ANTICUERPOS CUANT. IgM IgG COVID-19', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1557, 464, '002', 'IgM:', 'mlU/mL', '< 0.04', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1558, 464, '003', 'IgG', 'mlU/mL', '< 0.04', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1559, 465, '001', 'SHBG', 'nmol/L', '13.0 - 71.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1560, 453, '001', 'DENGUE NS1 (METODO INMUNOFLUOROCENCIA)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1561, 335, '020', 'MONONUCLEARES', '%', NULL, 'N', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1562, 198, '002', 'HEPATITIS C', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1563, 335, '021', 'HEMATIES', '', NULL, 'T', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1564, 466, '001', 'PROTEINURIA EN ORINA DE 2 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1565, 466, '002', 'PROTEINURIA:', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1566, 466, '003', 'PROTEINURIA EN 2 HORAS:', 'mg/2H', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1567, 466, '004', 'VOLUMEN URINARIO:', 'mL', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1568, 430, '002', 'COVID-19 ANTICUERPOS NEUTRALIZANTES', '', '< 0.04', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1569, 37, '004', '', '', NULL, 'E', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1570, 43, '002', '', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1571, 192, '002', 'IGA SERICA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1572, 193, '002', 'IGE SERICA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1573, 467, '001', 'DHEA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1574, 467, '002', 'DHEA', 'ug/mL', '80.0 - 340.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1575, 85, '024', 'PROTEINAS TOTALES:', 'mg/dL', '15.0 - 45.0', 'N', 17, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1576, 435, '002', 'CALPROTECTINA:', 'ug/g', '> 60.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1577, 424, '001', 'RT PCR COVID19', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1578, 469, '001', 'METANEFRINA SÉRICA', 'ng/L', '< 60.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1579, 320, '001', 'CATECOLAMINAS EN ORINA DE 24  HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1580, 320, '002', 'ADRENALINA', 'ug/24 h.', '< 20.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1581, 320, '003', 'NORADRENALINA', 'ug/24 h', '< 90.0', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1582, 470, '001', 'ANCA-C:', 'AU/mL', '> 18.1', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1583, 471, '001', 'ANCA-P:', 'AU/mL', '> 18.1', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1584, 471, '002', 'ANCA-P (ANTI MPO)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1585, 472, '001', 'ANTI BETA 2 GLICOPROTEÍNA IgM', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1586, 472, '002', 'ANTI BETA 2 GLICOPROTEÍNA IgM:', 'AU/mL', '> 20.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1587, 470, '002', 'ANCA-C (PROTEINASA 3 PR-3 IGG)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1588, 449, '001', 'ESTRÓGENOS TOTALES:', 'pg/mL', '34.0 - 246.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1589, 477, '001', 'PROTEINA C ULTRA SENSIBLE', 'mg/L', '> 6.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1590, 373, '019', 'MONONUCLEARES', '%', NULL, 'N', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1591, 373, '020', 'RECUENTO CELULAR', '', NULL, 'E', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1592, 484, '001', 'PRO-NPB', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1593, 484, '002', 'RESULTADO:', 'pg/ml', '< 450.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1594, 153, '041', 'VOLUMEN', 'mL', NULL, 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1595, 480, '001', 'AMONIO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1596, 480, '002', 'AMONIO:', 'mg/dL', '> 110.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1597, 485, '001', 'Aspergillus galactomanano', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1598, 80, '013', '.', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1599, 80, '014', '.', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1600, 80, '015', '.', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1601, 80, '016', '.', '', NULL, 'O', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1602, 80, '017', 'OBSERVACION:', '', NULL, 'O', 29, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1603, 80, '018', 'GERMEN AISLADO (2):', '', NULL, 'O', 32, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1604, 80, '019', '', '', NULL, 'E', 35, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1605, 80, '020', 'SENSIBLE:', '', NULL, 'O', 36, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1606, 80, '021', '-', '', NULL, 'O', 38, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1607, 80, '022', 'INTERMEDIO:', '', NULL, 'O', 39, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1608, 80, '023', '-', '', NULL, 'O', 40, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1609, 80, '024', 'RESISTENTE:', '', NULL, 'O', 42, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1610, 80, '025', '-', '', NULL, 'O', 44, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1611, 80, '026', 'OBSERVACION:', '', NULL, 'O', 45, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1612, 80, '027', 'GERMEN AISLADO (3):', '', NULL, 'O', 48, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1613, 80, '028', '', '', NULL, 'T', 51, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1614, 80, '029', 'SENSIBLE:', '', NULL, 'O', 52, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1615, 80, '030', '-', '', NULL, 'O', 53, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1616, 80, '031', 'INTERMEDIO:', '', NULL, 'O', 54, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1617, 80, '032', '-', '', NULL, 'O', 55, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1618, 80, '033', 'RESISTENTE:', '', NULL, 'O', 56, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1619, 80, '034', '-', '', NULL, 'O', 57, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1620, 80, '035', 'OBSERVACION:', '', NULL, 'O', 58, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1621, 80, '036', '-', '', NULL, 'E', 16, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1622, 80, '037', '-', '', NULL, 'E', 31, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1623, 80, '038', '-', '', NULL, 'E', 47, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1624, 207, '026', '.', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1625, 207, '027', '.', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1626, 207, '028', '.', '', NULL, 'O', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1627, 207, '029', '.', '', NULL, 'O', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1628, 207, '030', 'SENSIBLE:', '', NULL, 'O', 41, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1629, 207, '031', '.', '', NULL, 'E', 42, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1630, 207, '032', 'INTERMEDIO:', '', NULL, 'O', 43, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1631, 207, '033', '.', '', NULL, 'E', 44, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1632, 207, '034', 'RESISTENTE:', '', NULL, 'O', 45, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1633, 207, '035', 'OBSERVACIÓN:', '', NULL, 'O', 46, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1634, 80, '039', 'CONTAJE DE COLONIAS GERMEN (2):', 'UFC/mL', NULL, 'T', 33, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1635, 80, '040', '.', '', NULL, 'E', 34, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1636, 80, '041', 'CONTAJE DE COLONIAS GERMEN (3):', 'UFC/mL', NULL, 'T', 49, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1637, 80, '042', '.', '', NULL, 'E', 50, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1638, 81, '013', 'NOTA:', '', NULL, 'O', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1639, 327, '009', '.', '', NULL, 'E', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1640, 327, '010', '.', '', NULL, 'E', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1641, 327, '011', 'INTERMEDIO:', '', NULL, 'O', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1642, 327, '012', '.', '', NULL, 'E', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1643, 327, '013', 'RESISTENTE:', '', NULL, 'O', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1644, 80, '043', 'GRAM:', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1645, 80, '044', '.', '', NULL, 'E', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1646, 80, '045', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1647, 80, '046', '.', '', NULL, 'E', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1648, 80, '047', 'NOTA:', '', NULL, 'O', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1649, 80, '048', '.', '', NULL, 'E', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1650, 207, '036', 'GRAM:', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1651, 207, '037', '', '', NULL, 'E', 47, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1652, 207, '038', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1653, 207, '039', '.', '', NULL, 'E', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1654, 207, '040', '.', '', NULL, 'E', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1655, 207, '041', 'NOTA', '', NULL, 'O', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1656, 207, '042', '.', '', NULL, 'E', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1657, 237, '004', '.', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1658, 237, '005', '.', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1659, 237, '006', '.', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1660, 237, '007', '.', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1661, 306, '003', 'COLORACIÓN DE GRAM:', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1662, 306, '004', '.', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1663, 306, '005', '.', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1664, 306, '006', '.', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1665, 306, '007', '.', '', NULL, 'O', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1666, 306, '008', 'TIPO DE MUESTRA:', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1667, 395, '002', 'RESULTADO:', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1668, 82, '015', '.', '', NULL, 'E', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1669, 82, '016', 'INTERMEDIO:', '', NULL, 'O', 16, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1670, 82, '017', '.', '', NULL, 'E', 17, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1671, 82, '018', 'INTERMEDIO:', '', NULL, 'O', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1672, 82, '019', '.', '', NULL, 'E', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1673, 82, '020', 'RESISTENTE:', '', NULL, 'O', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1674, 82, '021', '.', '', NULL, 'E', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1675, 82, '022', 'NOTA:', '', NULL, 'O', 22, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1676, 124, '012', 'GERMEN AISLADO:', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1677, 124, '013', 'ANTIBIOGRAMA:', '', NULL, 'T', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1678, 124, '014', '.', '', NULL, 'E', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1679, 124, '015', 'SENSIBLE:', '', NULL, 'O', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1680, 124, '016', 'INTERMEDIO:', '', NULL, 'O', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1681, 124, '017', '.', '', NULL, 'E', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1682, 124, '018', 'RESISTENTE:', '', NULL, 'O', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1683, 124, '019', 'NOTA:', '', NULL, 'O', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1684, 124, '020', 'NOTA:', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1685, 188, '017', 'NOTA:', '', NULL, 'O', 17, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1686, 86, '006', 'PSA TOTAL Y LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1687, 379, '017', 'SEG. EOSINOFILOS', '%', NULL, 'N', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1688, 379, '018', 'RECUENTO DIFERENCIAL', '', NULL, 'E', 17, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1689, 379, '019', 'SEGMENTADOS NEUTROFILOS', '%', NULL, 'N', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1690, 379, '020', 'LINFOCITOS', '%', NULL, 'N', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1691, 379, '021', 'OBSERVACION:', '', NULL, 'O', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1692, 80, '049', '-', '', NULL, 'O', 26, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1693, 482, '001', 'CULTIVO DE ANAEROBIOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1694, 482, '002', 'FUENTE DE LA MUESTRA', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1695, 482, '003', 'RESULTADO', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1696, 378, '019', 'HEMATIES:', '', NULL, 'O', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1697, 378, '020', 'CONTAJE DE GLOBULOS BLANCOS:', 'mm3', NULL, 'N', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1698, 378, '021', 'RECUENTO DIFERENCIAL:', '', NULL, 'E', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1699, 378, '022', 'POLIMORFONUCLEARES:', '%', NULL, 'N', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1700, 378, '023', 'MONONUCLEARES:', '%', NULL, 'N', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1701, 489, '001', 'RESULTADO:', 'ng/mL', '0.8 - 2.4', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1702, 489, '002', 'DIGOXINA:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1703, 487, '001', 'PANEL DE ALIMENTOS VENEZUELA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1704, 52, '003', 'TESTOSTERONA LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1705, 491, '001', 'RETICULOCITOS:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1706, 491, '002', 'RESULTADO', '%', '0.5 - 1.5', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1707, 80, '050', '-', '', NULL, 'O', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1708, 80, '051', '-', '', NULL, 'O', 27, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1709, 487, '002', 'PANEL DE ALIMENTOS VZLA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1710, 80, '052', '.', '', NULL, 'O', 23, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1711, 80, '053', '.', '', NULL, 'O', 28, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1712, 80, '054', '.', '', NULL, 'E', 30, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1713, 80, '055', '.', '', NULL, 'O', 37, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1714, 80, '056', '-', '', NULL, 'O', 41, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1715, 80, '057', '-', '', NULL, 'O', 43, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1716, 80, '058', '-', '', NULL, 'O', 46, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1717, 80, '059', '-', '', NULL, 'O', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1718, 81, '014', '-', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1719, 81, '015', '-', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1720, 207, '043', '-', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1721, 207, '044', '-', '', NULL, 'O', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1722, 207, '045', '-', '', NULL, 'O', 25, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1723, 428, '001', 'SARS- COVID 19 ANTIGENO', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1724, 428, '002', '', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1725, 428, '003', '', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1726, 428, '004', '', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1727, 451, '002', '', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1728, 451, '003', '', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1729, 451, '004', '', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1730, 464, '004', '', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1731, 464, '005', '', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1732, 464, '006', '', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1733, 430, '003', '', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1734, 430, '004', '', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1735, 430, '005', '', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1736, 429, '004', '', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1737, 429, '005', '', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1738, 429, '006', '', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1739, 481, '001', 'PCR BRUCELLA', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1740, 426, '001', 'PCR CITOMEGALOVIRUS', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1741, 442, '001', 'PCR DENGUE', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1742, 425, '001', 'PCR EPSTEIN BARR', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1743, 468, '001', 'PCR ERLICHIA', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1744, 446, '001', 'PCR HEPATITIS B', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1745, 447, '001', 'PCR HEPATITIS C', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1746, 445, '001', 'PCR HERPES', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1747, 444, '001', 'PCR HIV', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1748, 478, '001', 'PCR MUTACION MTHFR A 1298 C', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1749, 479, '001', 'PCR MUTACION MTHFR C677T', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1750, 488, '001', 'PCR MYCOBACTERIUM TUBERCULOSIS', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1751, 490, '001', 'PCR ONCOGENES', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1752, 443, '001', 'PCR TORCH', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1753, 461, '001', 'PCR TOXOPLASMOSIS', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1754, 436, '001', 'MULTIPLEX I', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1755, 437, '001', 'MULTIPLEX II', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1756, 438, '001', 'MULTIPLEX III', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1757, 439, '001', 'MULTIPLEX IV', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1758, 440, '001', 'MULTIPLEX VII', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1759, 441, '001', 'MULTIPLEX VIII', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1760, 427, '001', 'VPH BIOPSIA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1761, 492, '001', 'HLA-B27', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1762, 125, '003', 'ACIDO LACTICO (LACTATO)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1763, 441, '002', '.', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1764, 455, '001', 'ELECTROFORESIS DE HB', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1765, 457, '001', 'OSMOLARIDAD URINARIA', 'mmol/Kg', '392.0 - 1090.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1766, 495, '001', 'OSMOLALIDAD URINARIA', 'mmol/kg.', '301.0 - 1093.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1767, 496, '001', 'Ag - Covid 19', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1768, 496, '002', 'Influenza A', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1769, 496, '003', 'Influenza  B', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1770, 496, '004', 'Virus Sincitial Respiratorio', '', NULL, 'T', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1771, 496, '005', 'Ag Mycoplasma pneumoniae', '', NULL, 'T', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1772, 496, '006', 'Adenovirus', '', NULL, 'T', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1773, 497, '001', 'LINFOCITOS CD3', '', NULL, 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1774, 497, '002', 'LINFOCITOS CD4', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1775, 497, '003', 'LINFOCITOS CD8', '', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1776, 380, '018', 'RECUENTO DIFERENCIAL', '', NULL, 'E', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1777, 380, '019', 'POLIMORFONUCLEARES', '%', NULL, 'N', 19, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1778, 380, '020', 'MONONUCLEARES', '%', NULL, 'N', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1779, 380, '021', 'DIRECTO:', '', NULL, 'E', 21, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1780, 380, '022', '-', '', NULL, 'O', 22, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1781, 486, '001', '.', '', NULL, 'O', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1782, 486, '002', '.', '', NULL, 'O', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1783, 358, '005', 'R.D.W', '%', NULL, 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1784, 279, '018', 'GLOBULOS ROJOS:', '10^6/mm3', '4.2 - 6.1', 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1785, 401, '021', 'CRISTALES:', '', NULL, 'O', 23, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1786, 401, '022', 'OTROS:', '', NULL, 'O', 24, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1787, 498, '001', 'CADENAS LIGERAS KAPPA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1788, 498, '002', 'CADENAS LIGERAS KAPPA', 'g/L', '2.0 - 4.4', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1789, 499, '001', 'CADENAS LIGERAS LAMBDA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1790, 499, '002', 'CADENAS LIGERAS LAMBDA', 'g/L', '1.1 - 2.4', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1791, 500, '001', 'BETA 2 MICROGLOBULINAS EN ORINA PARCIAL', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1792, 500, '002', 'BETA 2 MICROGLOBULINAS EN ORINA PARCIAL', 'mg/L', '< 0.25', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1793, 501, '001', 'ÁCIDO VANILMANDÉLICO EN ORINA DE 24 HORAS', '', NULL, 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1794, 502, '001', 'Clostridium difficile ANTÍGENO EN HECES', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1795, 502, '002', 'Clostridium difficile', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1796, 503, '001', 'Salmonella typhi', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1797, 503, '002', 'Salmonella paratyphi', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1798, 279, '019', 'VCM', 'fL', '83.0 - 97.0', 'N', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1799, 279, '020', 'HCM', 'pg', '27.0 - 32.0', 'N', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1800, 279, '021', 'CHCM', 'g/dL', '32.0 - 35.0', 'N', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1801, 193, '003', 'IGE SERICA', 'IU/mL', '< 100.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1802, 505, '001', 'CALCIO IÓNICO (iCa)', 'mmol/L', '1.1 - 1.35', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1803, 504, '001', 'PANEL MIXTO ATOPICOS', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1804, 476, '001', 'INMUNOFENOTIPAJE CD3', '', NULL, 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1805, 476, '002', 'INMUNOFENOTIPAJE CD4', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1806, 476, '003', 'INMUNOFENOTIPAJE CD8', '', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1807, 475, '001', 'CELULAS NK', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1808, 506, '001', 'DENGUE IGG', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1809, 506, '002', 'DENGUE IGM', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1810, 506, '003', 'ANTÍGENO NS1 DE DENGUE', '', NULL, 'T', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1811, 507, '001', 'HE4', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1812, 105, '002', 'COCAINA EN ORINA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1813, 106, '002', 'MARIHUANA EN ORINA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1814, 507, '003', 'HE 4 (Proteína Epididimal Humana 4)', 'pmol/L', '< 90.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1815, 362, '001', 'INFLUENZA (IGG - IGM)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1816, 362, '002', 'IGG DE INFLUENZA  A+B', 'UI/mL', '> 2.1', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1817, 362, '003', 'IGM DE INFLUENZA  A+B', 'UI/mL', '> 1.1', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1818, 510, '001', 'MERCURIO EN SANGRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1819, 510, '002', 'MERCURIO', 'ug/dL', '> 2.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1820, 509, '001', 'COBRE EN SANGRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1821, 509, '002', 'COBRE', 'umol/L', '12.6 - 24.4', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1822, 511, '001', 'CERULOPLASMINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1823, 511, '002', 'CERULOPLASMINA', 'mg/dL', '15.0 - 60.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1824, 492, '002', 'HLA-B27', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1825, 321, '002', 'ADRENALINA', 'pg/mL', '< 100.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1826, 321, '003', 'NORADRENALINA', 'pg/mL', '< 600.0', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1827, 321, '004', 'DOPAMINA', 'pg/mL', '< 100.0', 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1828, 320, '004', 'DOPAMINA', 'ug/24 h.', '< 600.0', 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1829, 417, '002', 'ANTICUERPOS ANTITIROGLOBULINA (ANTI-TG)', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1830, 514, '001', 'Tuberculosis IGRA (Interferón Gamma)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1831, 514, '002', 'Tuberculosis IGRA (Interferón Gamma):', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1832, 512, '001', 'HEMOCULTIVO', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1833, 512, '002', 'TIPO DE MUESTRA: SANGRE', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1834, 512, '003', '.', '', NULL, 'E', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1835, 512, '004', 'RESULTADO DEL CULTIVO', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1836, 512, '005', '.', '', NULL, 'E', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1837, 512, '006', 'NOTA:', '', NULL, 'O', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1838, 512, '009', '.', '', NULL, 'E', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1839, 512, '010', 'ANTIBIOGRAMA', '', NULL, 'O', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1840, 512, '011', '.', '', NULL, 'E', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1841, 512, '012', 'SENSIBLE:', '', NULL, 'O', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1842, 512, '013', '.', '', NULL, 'E', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1843, 512, '014', 'INTERMEDIO', '', NULL, 'O', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1844, 512, '015', '.', '', NULL, 'E', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1845, 512, '016', 'RESISTENTE:', '', NULL, 'O', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1846, 512, '017', '.', '', NULL, 'E', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1847, 512, '018', 'NOTA:', '', NULL, 'O', 16, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1848, 513, '001', 'TIPO DE MUESTRA: SANGRE', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1849, 513, '002', '.', '', NULL, 'E', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1850, 513, '003', 'RESULTADO DEL CULTIVO:', '', NULL, 'O', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1851, 513, '004', '.', '', NULL, 'E', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1852, 513, '005', 'NOTA:', '', NULL, 'O', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1853, 513, '006', '.', '', NULL, 'E', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1854, 513, '007', 'GERMEN AISLADO:', '', NULL, 'O', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1855, 513, '008', '.', '', NULL, 'E', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1856, 513, '009', 'ANTIBIOGRAMA:', '', NULL, 'O', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1857, 513, '010', 'SENSIBLE:', '', NULL, 'O', 10, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1858, 513, '011', '.', '', NULL, 'E', 11, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1859, 513, '012', 'INTERMEDIO:', '', NULL, 'O', 12, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1860, 513, '013', '.', '', NULL, 'E', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1861, 513, '014', 'RESISTENTE:', '', NULL, 'O', 14, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1862, 513, '015', '.', '', NULL, 'E', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1863, 513, '016', 'NOTA:', '', NULL, 'O', 16, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1864, 515, '001', 'PCR ZIKA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1865, 515, '002', 'PCR ZIKA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1866, 443, '002', 'TOXOPLASMA', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1867, 443, '003', 'RUBEOLA', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1868, 443, '004', 'CITOMEGALOVIRUS', '', NULL, 'T', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1869, 443, '005', 'HERPES', '', NULL, 'T', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1870, 493, '001', 'TACROLIMUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1871, 493, '002', 'TACROLIMUS', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1872, 516, '001', 'ANTI-CORE IGM. HEPATITIS B:', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1873, 516, '002', 'ANTI-CORE IGG. HEPATITIS B:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1874, 207, '046', '-', '', NULL, 'O', 26, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1875, 207, '047', '-', '', NULL, 'O', 27, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1876, 514, '003', 'Diagnostic for Human Tuberculosis:', '', NULL, 'T', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1877, 514, '004', '.', '', NULL, 'E', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1878, 286, '003', 'ANTICUERPOS ANTITIROIDEOS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1879, 469, '002', 'METANEFRINAS EN SANGRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1880, 517, '001', 'METANEFRINA EN ORINA DE 24 HORAS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1881, 517, '002', 'METANEFRINA EN ORINA DE 24 HORAS', 'ug/24H', '20.0 - 320.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1882, 517, '003', 'Volumen Urinario', 'mL/24H.', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1883, 518, '001', 'ANTI- SMITH', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1884, 518, '002', 'ANTI SMITH', 'U/mL', '< 15.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1885, 520, '001', 'ANTI-LA (SSB)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1886, 520, '002', 'ANTI-LA', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1887, 519, '001', 'ANTI-RO (SSA)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1888, 519, '002', 'ANTI-RO', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1889, 521, '001', 'PARVOVIRUS B19 / ERYTHROVIRUS', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1890, 521, '002', 'PARVOVIRUS B19', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1891, 522, '001', 'GASTRINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1892, 522, '002', 'GASTRINA', 'pg/mL', '25.0 - 90.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1893, 525, '001', 'RELACION CALCIO / CITRATO EN 2DA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1894, 525, '002', 'CALCIO EN 2DA ORINA', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1895, 525, '003', 'CITRATO EN 2DA ORINA', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1896, 525, '004', 'RELACION CALCIO / CITRATO', '', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1897, 523, '001', 'RELACION CITRATO / CREATININA EN 2DA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1898, 523, '002', 'CITRATO EN 2DA ORINA', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1899, 523, '003', 'CREATININA EN 2DA ORINA', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1900, 523, '004', 'RELACION CITRATO / CREATININA', '', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1901, 524, '001', 'RELACION OXALATO / CREATININA EN 2DA ORINA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1902, 524, '002', 'OXALATO EN 2DA ORINA', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1903, 524, '003', 'CREATININA EN 2DA ORINA', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1904, 524, '004', 'RELACION OXALATO / CREATININA', '', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1905, 526, '001', 'ANTICOAGULANTE LÚPICO', 'SEGUNDOS', '60.0 - 120.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1906, 526, '002', '', '', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1907, 401, '023', 'BILIRRUBINA:', '', NULL, 'T', 13, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1908, 527, '001', 'ANTICUERPOS ANTI JO-1', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1909, 527, '002', 'ANTICUERPOS ANTI JO-1', 'U/mL', '> 25.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1910, 84, '002', 'PSA TOTAL', '', '< 4.0', 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1911, 206, '002', 'PSA LIBRE', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1912, 187, '002', 'CORTISOL 8 AM', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1913, 147, '002', 'CORTISOL 4 PM', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1914, 194, '002', 'IGF-1', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1915, 528, '001', 'OSMOLARIDAD PLASMÁTICA', 'mOsmol/Kg.', '280.0 - 301.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1916, 529, '001', 'CARGA VIRAL DE HEPATITIS C', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1917, 508, '001', 'CARGA VIRAL DE HIV', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1918, 457, '002', 'OSMOLARIDAD URINARIA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1919, 528, '002', 'OSMOLARIDAD PLASMÁTICA', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1920, 530, '001', 'PANEL IGG 4 NUTRICIONAL VE1', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1921, 531, '001', 'PANEL IGG NUTRICIONAL 24 ELISA', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1922, 532, '001', 'SODIO:', 'mEq/L', '135.0 - 155.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1923, 532, '002', 'POTASIO:', 'mEq/L', '3.4 - 5.3', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1924, 535, '001', 'PRUEBA DE EMBARAZO:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1925, 533, '001', 'H.I.V.', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1926, 536, '001', 'TOXOPLASMOSIS (IgM):', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1927, 537, '001', 'HEPATITIS A:', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1928, 539, '001', 'HEPATITIS B (HBcore)', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1929, 538, '001', 'HEPATITIS B (HBAgs)', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1930, 540, '001', 'HEPATITIS C (HCV)', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1931, 401, '024', 'LEUCOCITOS', '', NULL, 'T', 15, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1932, 394, '001', 'PROTEINA C REACTIVA (PCR)', 'mg/L', '< 0.8', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1933, 279, '022', 'HEMOGLOBINA:', 'g/dL', '12.0 - 16.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1934, 541, '001', 'DENGUE IGG', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1935, 542, '001', 'DENGUE IGM', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1936, 534, '001', 'V.D.R.L', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1937, 311, '004', 'T.G.P:', 'U/L', '> 40.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1938, 109, '001', 'HEMOGLOBINA GLICOSILADA HbA1c', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1939, 109, '002', 'HEMOGLOBINA GLICOSILADA HbA1c', '%', '4.5 - 6.3', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1940, 119, '001', 'TROPONINA I (ULTRA SENSIBLE)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1941, 119, '002', 'TROPONINA I (ULTRA SENSIBLE)', 'ng/mL', '< 0.3', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1942, 54, '003', 'GAMMA GLUTAMIL (G.G.T)', 'UI/L', '7.0 - 32.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1943, 122, '007', 'TRIGLICERIDOS', 'mg/dL', '> 165.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1944, 535, '002', 'PRUEBA DE EMBARAZO (H.C.G)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1945, 41, '039', 'RESTOS DE ALIMENTOS:', '', NULL, 'T', 9, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1946, 76, '002', 'T.S.H.', 'uIU/ml', '0.3 - 4.2', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1947, 169, '001', 'Helicobacter Pylori IgG:', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1948, 547, '001', 'Helicobacter Pylori en Heces (Antigeno):', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1949, 547, '002', 'Helicobacter Pylori en Heces (Antigeno):', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1950, 41, '040', 'OLOR', '', NULL, 'T', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1951, 41, '041', 'OTROS', '', NULL, 'O', 18, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1952, 549, '001', 'PRUEBA ESPECIAL C', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1953, 551, '001', 'PRUEBA ESPECIAL H', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1954, 550, '001', 'PRUEBA ESPECIAL M', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1955, 552, '001', 'PRUEBA ESPECIAL V', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1956, 545, '001', 'SODIO', 'mEq/L', '135.0 - 155.0', 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1957, 544, '001', 'POTASIO', 'mEq/L', '3.4 - 5.3', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1958, 553, '001', 'CARGA DE 75 gr', '', NULL, 'E', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1959, 553, '002', 'GLICEMIA A LOS 60 MINUTOS', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1960, 553, '003', 'GLICEMIA A LOS 120 MINUTOS', 'mg/dL', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1961, 553, '004', 'GLICEMIA BASAL', 'ml/dL', '70.0 - 110.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1962, 156, '005', 'LEUCOGRAMA:', '', NULL, 'O', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1963, 401, '025', 'CÉLULAS REDONDAS:', '', NULL, 'T', 20, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1964, 548, '001', 'COLINESTERASA:', 'U/L', '3650.0 - 9120.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1965, 554, '001', 'PRUEBA ESPECIAL E', '', NULL, 'T', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1966, 543, '001', 'CLORO', 'mEq/L', '95.0 - 115.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1967, 506, '004', 'SEROLOGIA DE DENGUE IGG-IGM-NS1', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1968, 98, '002', 'GLICEMIA A LOS 60 MINUTOS', 'mg/dL', NULL, 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1969, 98, '003', 'GLICEMIA A LOS 120 MINUTOS', 'mg/dL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1970, 89, '003', 'INSULINA A LOS 60 MINUTOS', 'uUI/mL', NULL, 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1971, 89, '004', 'INSULINA A LOS 120 MINUTOS', 'uUI/mL', NULL, 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1972, 555, '001', 'HIV (ELISA DE 4TA GENERACION)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1973, 555, '002', 'HIV', 'UI/mL', '> 1.1', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1974, 303, '002', 'pH', '', '7.35 - 7.45', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1975, 303, '003', 'pCO2', 'mmHg', '35.0 - 45.0', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1976, 303, '004', 'pO2', 'mmHg', '80.0 - 105.0', 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1977, 303, '005', 'HCO-3', 'mmol/L', '18.0 - 27.0', 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1978, 303, '006', 'BE(b)', 'mmol/L', '-2.0 - 3.0', 'N', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1979, 303, '007', 'cSO2', '%', '92.0 - 100.0', 'N', 8, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1980, 166, '002', 'pH:', '', '7.31 - 7.41', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1981, 166, '003', 'pCO2', 'mmHg', '41.0 - 51.0', 'N', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1982, 166, '004', 'pO2', 'mmHg', '35.0 - 40.0', 'N', 4, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1983, 166, '005', 'HCO-3', 'mmol/L', '18.0 - 27.0', 'N', 5, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1984, 166, '006', 'BE(b)', '', '-2.0 - 3.0', 'N', 7, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1985, 45, '001', 'FERRITINA', 'ng/mL', '10.0 - 124.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1986, 166, '007', 'BE(ecf)', 'mmol/L', NULL, 'N', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1987, 303, '008', 'BE(ecf)', 'mmol/L', NULL, 'N', 6, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1988, 29, '001', 'HIERRO SERICO:', 'Ug/dL', '50.0 - 170.0', 'N', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1989, 556, '001', 'LEPTOSPIRA (IGG-IGM)', '', NULL, 'E', 1, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1990, 556, '002', 'LEPTOSPIRA IGG:', '', NULL, 'T', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1991, 556, '003', 'LEPTOSPIRA IGM:', '', NULL, 'T', 3, '2025-11-25 21:55:04', '2025-11-25 21:55:04');
INSERT INTO `lab_exam_items` VALUES (1992, 453, '002', 'DENGUE NS1', '', '> 100.0', 'N', 2, '2025-11-25 21:55:04', '2025-11-25 21:55:04');

-- ----------------------------
-- Table structure for lab_exams
-- ----------------------------
DROP TABLE IF EXISTS `lab_exams`;
CREATE TABLE `lab_exams`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lab_category_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abbreviation` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `lab_exams_code_unique`(`code`) USING BTREE,
  INDEX `lab_exams_lab_category_id_foreign`(`lab_category_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 557 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_exams
-- ----------------------------
INSERT INTO `lab_exams` VALUES (15, '0002', 11, 'PLAQUETAS', 'PLAQ', 0.00, 1, '2025-11-25 21:53:06', '2025-11-25 21:53:06');
INSERT INTO `lab_exams` VALUES (16, '0003', 11, 'V.S.G  SEDIMENTACION GLOBULAR', 'VSG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (17, '0004', 16, 'P.T.', 'PT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (18, '0005', 16, 'FIBRINOGENO', 'FIBRI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (19, '0007', 34, 'UREA', 'UREA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (20, '0008', 34, 'CREATININA', 'CREAT', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (21, '0009', 34, 'COLESTEROL TOTAL', 'COLTO', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (22, '0010', 34, 'TRIGLICERIDOS', 'TRIGL', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (23, '0011', 34, 'ACIDO URICO EN SANGRE', 'ACU', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (24, '0012', 34, 'FOSFATASA ALCALINA', 'FOALC', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (25, '0013', 34, 'FOSFATASA ACIDA PROSTATICA', 'FOACI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (26, '0014', 34, 'CALCIO', 'CALC', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (27, '0015', 34, 'FOSFORO', 'FOS', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (28, '0016', 34, 'MAGNESIO', 'MAG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (29, '0018', 34, 'HIERRO SERICO', 'HISER', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (30, '0019', 15, 'EPAMIN', 'EPA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (31, '0021', 15, 'CARBAMAZEPINA (TEGRETOL)', 'CARBA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (32, '0025', 34, 'AMILASA  EN SANGRE', 'AMILA', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (33, '0027', 34, 'CK-MB', 'CKMB', 10.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (34, '0028', 34, 'PROTEINAS TOTALES Y FRACCIONADAS', 'PROTF', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (35, '0032', 34, 'MONO-TEST', 'MONOT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (36, '0033', 17, 'C3', 'C3', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (37, '0034', 17, 'CH 50', 'CH50', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (38, '0035', 17, 'IGG. SERICA', 'IGGSE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (39, '0036', 17, 'IGM SERICA', 'IGMSE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (40, '0040', 34, 'DEPURACION DE CREATININA', 'DEPCR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (41, '0041', 18, 'HECES', 'HECES', 3.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (42, '0042', 18, 'SANGRE OCULTA EN HECES', 'SOHEC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (43, '0043', 17, 'IGA SECRETORA', 'IGASE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (44, '0044', 17, 'ANTI DNA', 'ANDNA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (45, '0045', 34, 'FERRITINA', 'FERRI', 13.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (46, '0047', 37, 'T3 TOTAL', 'T3TOT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (47, '0048', 37, 'T4 LIBRE', 'T4LIB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (48, '0049', 15, 'LH', 'LH', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (49, '0050', 15, 'FSH', 'FSH', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (50, '0051', 15, 'ESTRADIOL', 'ESTRA', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (51, '0052', 15, 'PROGESTERONA', 'PROGE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (52, '0053', 15, 'TESTOSTERONA LIBRE', 'TESTL', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (53, '0054', 15, 'HORMONA DE CRECIMIENTO BASAL', 'HORCB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (54, '0055', 34, 'GGT', 'GGT', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (55, '0056', 20, 'CA 15.3', 'CA15', 17.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (56, '0057', 20, 'CA 19.9', 'CA19', 19.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (57, '0058', 20, 'CA 72.4', 'CA72', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (58, '0059', 20, 'CA 125', 'CA125', 18.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (59, '0063', 34, 'CETONEMIA', 'CETON', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (60, '0064', 20, 'ALFA FETOPROTEINAS (AFP)', 'AFP', 18.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (61, '0065', 18, 'AZUCARES REDUCTORES EN HECES', 'ARH', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (62, '0066', 15, 'ACIDO VALPROICO', 'AVAL', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (63, '0067', 37, 'T3 LIBRE', 'T3LIB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (64, '0068', 34, 'L.E. TEST', 'CELE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (65, '0071', 18, 'SUDAN III', 'SUDAN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (66, '0072', 15, 'VITAMINA B12', 'B12', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (67, '0073', 15, 'ANTICUERPOS ANTIMICROSOMALES (TPO)', 'A-TPO', 15.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (68, '0075', 15, 'PROLACTINA', 'PROLA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (69, '0076', 37, 'T4 TOTAL', 'T4TOT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (70, '0077', 13, 'CETONURIA', 'CETON', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (71, '0078', 15, 'H.C.G. BETA CUANTITATIVA (EMBARAZO)', 'HCG', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (72, '0080', 20, 'CA 21.1', 'CA21', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (73, '0082', 15, 'RUBEOLA (IGG)', 'RUIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (74, '0083', 15, 'INSULINA POSTCARGA', 'INS60', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (75, '0084', 11, 'FROTIS DE SANGRE PERIFERICA', 'FSP', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (76, '0085', 37, 'T.S.H.', 'TSH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (77, '0086', 15, 'TIROGLOBULINA', 'TIROG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (78, '0087', 34, 'GLICEMIA POST PRANDIAL 2 HORAS', 'GL120', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (79, '0089', 15, 'ANTICUERPOS ANTIMITOCONDRIALES', 'AANTI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (80, '0090', 22, 'UROCULTIVO', 'UROCU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (81, '0091', 22, 'COPROCULTIVO', 'COPRO', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (82, '0092', 22, 'ESPERMOCULTIVO', 'ESPER', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (83, '0093', 11, 'GRUPO SANGUINEO  Y FACTOR', 'GRUSA', 3.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (84, '0094', 15, 'PSA TOTAL', 'PSATO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (85, '0095', 34, 'CITOQUIMICO LIQUIDOS BIOLOGICOS', 'CLB', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (86, '0099', 15, 'PSA TOTAL Y LIBRE', 'PSATL', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (87, '0100', 15, 'HOMOCISTEINA', 'HOMOC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (88, '0101', 35, 'CHLAMYDIA TRACHOMATIS (IGM)', 'CTIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (89, '0102', 15, 'INSULINA BASAL, 60 Y 120 MINUTOS', 'INSBA', 46.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (90, '0103', 35, 'CITOMEGALOVIRUS (IGG)', 'CIIGG', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (91, '0104', 35, 'CITOMEGALOVIRUS (IGM)', 'CIIGM', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (92, '0105', 22, 'K.O.H.', 'KOH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (93, '0106', 35, 'EPSTEIN BARR - IGG', 'EPIGG', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (94, '0107', 14, 'R. A. TEST', 'SERAT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (95, '0108', 34, 'DEPURACION DE UREA', 'DEURE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (96, '0110', 15, 'HERPES (IGG)', 'HEIGG', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (97, '0111', 15, 'TESTOSTERONA TOTAL', 'TESTO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (98, '0112', 34, 'GLICEMIA BASAL, 60 Y 120 MINUTOS', 'GLIBA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (99, '0113', 15, 'INSULINA', 'INSUL', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (100, '0114', 18, 'ROTAVIRUS', 'ROTAV', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (101, '0115', 15, 'PROCALCITONINA', 'PROCA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (102, '0116', 17, 'C4', 'C4', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (103, '0118', 35, 'CHLAMYDIA TRACHOMATIS (IGG)', 'CTIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (104, '0119', 35, 'EPSTEIN BARR - IGM', 'EPIGM', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (105, '0123', 26, 'COCAINA', 'COCOR', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (106, '0124', 26, 'MARIHUANA', 'MARIH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (107, '0125', 16, 'P.T.T.', 'PTT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (108, '0126', 20, 'ANTIGENO CARCINOEMBRONARIO (CEA)', 'CEA', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (109, '0127', 15, 'HEMOGLOBINA GLICOSILADA HBA1C', 'HGLIC', 17.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (110, '0128', 34, 'COLESTEROL HDL', 'COHDL', 2.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (111, '0129', 34, 'PERFIL LIPIDICO', 'PELIP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (112, '0133', 15, 'INSULINA POSTPRANDIAL', 'IPP', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (113, '0139', 14, 'HELICOBACTER PYLORI (IGM)', 'HPYLO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (114, '0140', 15, '17 HIDROXIPROGESTERONA', '17HID', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (115, '0142', 19, 'ANTI CORE IGM HEPATITIS B', 'ACIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (116, '0143', 19, 'ANTIGENO DE SUPERFICIE', 'ASUPE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (117, '0148', 34, 'COLESTEROL LDL', 'COLDL', 2.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (118, '0149', 15, 'ACIDO FOLICO', 'AFOLI', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (119, '0150', 15, 'TROPONINA I ULTRA SENSIBLE', 'TROPO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (120, '0151', 34, 'ELECTROLITOS SERICO (NA K CL)', 'ESERI', 17.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (121, '0152', 34, 'ELECTROLITOS EN ORINA PARCIAL', 'EURIN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (122, '0156', 34, 'COLESTEROL TOTAL Y FRACCIONADO', 'CTF', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (123, '0157', 34, 'BILIRRUBINA TOTAL Y FRACCIONADA', 'BTF', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (124, '0160', 22, 'EXUDADO FARINGEO', 'EXUFA', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (125, '0164', 15, 'ACIDO LACTICO (LACTATO)', 'ALACT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (126, '0167', 34, 'A.S.L.O. TITULO DE ESTREPTOLISINA O', 'ASLO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (127, '0171', 15, 'ALDOLASA', 'ALDOL', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (128, '0173', 34, 'AMILASA EN ORINA', 'AMORI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (129, '0178', 17, 'ANTI CARDIOLIPINAS (IGM)', 'ACIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (130, '0179', 17, 'ANTI CARDIOLIPINAS (IGG)', 'ACIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (131, '0181', 17, 'ANTI FOSFOLIPIDOS (IGM)', 'AFIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (132, '0182', 17, 'ANTI FOSFOLIPIDOS (IGG)', 'AFIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (133, '0183', 14, 'ANTIGENOS FEBRILES', 'AFEBR', 7.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (134, '0187', 15, 'ANTI HTLV I &II', 'AHTLV', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (135, '0194', 15, 'ANTI PEPTIDO CITRULINADO (ANTI CCP)', 'APCIT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (136, '0195', 17, 'ANTI RNA', 'ARNA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (137, '0201', 17, 'B2 GLICOPROTEINAS (IGM)', 'B2IGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (138, '0202', 17, 'B2 GLICOPROTEINAS (IGG)', 'B2IGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (139, '0206', 17, 'C1 INHIBIDOR', 'C1INH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (140, '0208', 13, 'PROTEINA DE BENCE JONES', 'PBJ', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (141, '0209', 34, 'PROTEINURIA EN ORINA PARCIAL', 'PINUR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (142, '0211', 15, 'PTH', 'PTH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (143, '0217', 16, 'RETRACCION DEL COAGULO', 'RCOAG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (144, '0219', 34, 'CALCIO EN ORINA', 'CORIN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (145, '0221', 15, 'CALCITONINA', 'CALCI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (146, '0225', 34, 'CK', 'CK', 10.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (147, '0227', 15, 'CORTISOL 4PM', 'C4PM', 12.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (148, '0228', 15, 'CORTISOL URINARIO', 'COROR', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (149, '0230', 34, 'CREATININA EN ORINA PARCIAL', 'CREOR', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (150, '0231', 20, 'CYFRA 21-1', 'CYPFR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (151, '0232', 34, 'DENSIDAD URINARIA', 'DENUR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (152, '0234', 15, 'DHEA-SO4', 'DHEA', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (153, '0243', 29, 'ESPERMATOGRAMA', 'ESPER', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (154, '0248', 15, 'FENOBARBITAL', 'FENOB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (155, '0252', 34, 'LDH', 'LDH', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (156, '0256', 18, 'LEUCOGRAMA FECAL', 'LEUFE', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (157, '0259', 34, 'LIPASA', 'LIPAS', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (158, '0261', 14, 'A.S.T.O', 'SEAST', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (159, '0262', 34, 'MAGNESIO EN ORINA', 'MAGOR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (160, '0264', 35, 'MYCOPLASMA PNEUMONIAE IGM', 'MYCOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (161, '0266', 11, 'MORFOLOGIA DE GLOBULOS ROJOS', 'MORGR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (162, '0267', 15, 'PLOMO EN SANGRE', 'NPSAN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (163, '0274', 15, 'PEPTIDO C', 'PETIC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (164, '0275', 34, 'FOSFORO EN ORINA PARCIAL', 'FORIN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (165, '0276', 15, 'FTA (TREPONEMA PALLIDUM)', 'FTA', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (166, '0277', 36, 'GASES VENOSOS', 'GAVEN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (167, '0278', 34, 'GLUCOSURIA BASAL', 'GLUBA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (168, '0279', 34, 'GLUCOSURIA P.P.', 'GLUPP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (169, '0280', 14, 'HELICOBACTER PYLORI (IGG)', 'HELPI', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (170, '0281', 15, 'HORMONA CRECIMIENTO POST ESTIMULO', 'HCPES', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (171, '0282', 15, 'IGFBP3', 'IGFBP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (172, '0290', 16, 'TIEMPO DE  SANGRIA', 'TCSAN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (173, '0295', 34, 'UREA EN ORINA DE 24 HORAS', 'UOR24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (174, '0296', 34, '% SATURACION DE LA TRANSFERRINA', '%SATU', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (175, '0297', 34, 'CALCIO EN ORINA DE 24 HRS', 'COR24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (176, '0300', 18, 'ADENOVIRUS - ROTAVIRUS', 'ADENO', 22.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (177, '0301', 34, 'TGP', 'TGP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (178, '0302', 15, 'ANDROSTENODIONA', 'ANDRO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (179, '0303', 19, 'ANTIGENO AUSTRALIA (AU)', 'AEHEB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (180, '0304', 19, 'HEPATITIS A (IGM)', 'AIGMA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (181, '0305', 19, 'HEPATITIS A (IGG)', 'AIGGA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (182, '0306', 34, 'TGO', 'TGO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (183, '0308', 34, 'REL CALCIO/CREATININA EN ORINA', 'CACRP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (184, '0309', 34, 'RELACION FOSFORO/CREATININA(P/CR)', 'RFCRE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (185, '0310', 35, 'CHLAMYDIA PNEUMONIAE (IGM)', 'CHIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (186, '0312', 35, 'CHLAMYDIA PNEUMONIAE (IGG)', 'CHIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (187, '0314', 15, 'CORTISOL 8AM', 'COR8A', 12.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (188, '0315', 30, 'HEMOCULTIVO 1', 'HEMO1', 26.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (189, '0316', 34, 'CURVA GLUCOSA 0, 60, 120, 240 MIN', 'CTG1', 13.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (190, '0320', 20, 'FACTORES DE NECROSIS TUMORAL', 'FNETU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (191, '0321', 15, 'HERPES (IGM)', 'HEIGM', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (192, '0322', 17, 'IGA SERICA', 'IGASE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (193, '0323', 17, 'IGE SERICA', 'IGESE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (194, '0324', 15, 'IGF1', 'IGF1', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (195, '0325', 35, 'MYCOPLASMA PNEUMONIAE IGG', 'MYIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (196, '0326', 34, 'CAPACIDAD FIJACION FE (TIBC)', 'TIBC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (197, '0327', 34, 'UREA EN ORINA PARCIAL', 'UORPA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (198, '0328', 19, 'ANTICUERPOS CONTRA HEPATITIS C', 'AIGGC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (199, '0329', 19, 'ANTI HBS AG (AG DE SUPER)', 'AHBS', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (200, '0330', 15, 'RUBEOLA (IGM)', 'RUIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (201, '0331', 34, 'COLESTEROL VLDL', 'CVLDL', 2.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (202, '0332', 15, 'ANTI TIROGLOBULINICOS (ANTI TG)', 'ANTTG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (203, '0333', 17, 'ANTICUERPOS ANTINUCLEARES (ANA)', 'ANA', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (204, '0340', 15, 'TRANSFERRINA', 'TRANS', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (205, '0341', 34, 'GLICEMIA', 'GLI2P', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (206, '0345', 15, 'PSA LIBRE', 'PSALI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (207, '0349', 22, 'CULTIVOS VARIOS', 'CULTI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (208, '0350', 19, 'CORE B', 'CTOTA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (209, '0352', 17, 'ANTI BETA 2 GLICOPROTEINA IGG', 'ABET2', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (210, '0353', 11, 'CONTAJE BLANCO Y FORMULA', 'CUEFO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (211, '0361', 34, 'ELECTROLITOS EN LIQ PERITONEAL', 'ELP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (212, '0362', 34, 'COLESTEROL Y TRIGLICERIDOS', 'CT', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (213, '0363', 34, 'ALBUMINA', 'ALB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (214, '0365', 34, 'ACIDO URICO EN ORINA DE 1 HORA', 'AU1H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (215, '0366', 34, 'ACIDO URICO EN ORINA DE 2 HORAS', 'AU2H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (216, '0367', 34, 'ACIDO URICO EN ORINA DE 24 HORAS', 'AU24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (217, '0368', 34, 'ACIDO URICO EN SEGUNDA ORINA', 'AU2A', 4.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (218, '0369', 34, 'ALBUMINA EN ORINA PARCIAL', 'ALBOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (219, '0370', 34, 'ALBUMINURIA EN 12 HORAS', 'ALB12', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (220, '0371', 34, 'ALBUMINURIA EN 24 HORAS', 'ALB24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (221, '0373', 34, 'AMILASURIA EN 12 HORAS', 'AM12H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (222, '0374', 34, 'AMILASURIA EN 24 HORAS', 'AM24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (223, '0375', 34, 'AMILASURIA EN 2 HORAS', 'AM2H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (224, '0376', 34, 'AMILASURIA EN 6 HORAS', 'AM6H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (225, '0377', 34, 'AMILASURIA EN 4 HORAS', 'AM4H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (226, '0378', 13, 'AZUCARES REDUCTORES EN ORINA', 'AZRO', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (227, '0379', 18, 'AZUCARES NO REDUCTORES EN HECES', 'AZNRH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (228, '0380', 34, 'CALCIO EN ORINA DE 2 HORAS', 'CAO2H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (229, '0381', 34, 'CALCIO EN ORINA DE 12 HORAS', 'CAO12', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (230, '0382', 34, 'CALCIO EN SEGUNDA ORINA', 'CA2AO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (231, '0383', 34, 'CITRATO EN ORINA DE 24 HORAS', 'CIT24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (232, '0384', 34, 'CITRATO EN ORINA PARCIAL', 'CITOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (233, '0385', 34, 'CREATININA EN ORINA DE 2 HORAS', 'CRE2H', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (234, '0386', 34, 'CREATININA EN ORINA DE 12 HORAS', 'CRE12', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (235, '0387', 34, 'CREATININA EN ORINA DE 24 HORAS', 'CRE24', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (236, '0388', 34, 'CREATININA EN SEGUNDA ORINA', 'CR2AO', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (237, '0389', 22, 'GRAM DE ORINA', 'GRAMO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (238, '0390', 34, 'LIPASA EN ORINA DE 12 HORAS', 'LIO12', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (239, '0391', 34, 'NITROGENO EN ORINA PARCIAL', 'NITOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (240, '0392', 34, 'NITROGENO UREICO EN ORINA 24 HORAS', 'NU24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (241, '0393', 34, 'OXALATO EN ORINA PARCIAL', 'OXOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (242, '0394', 34, 'PROTEINURIA EN ORINA DE 12 HORAS', 'PR12H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (243, '0395', 34, 'PROTEINURIA EN ORINA DE 24 HORAS', 'PR24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (244, '0396', 34, 'PROTEINURIA MINUTADA', 'PRMIN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (245, '0397', 34, 'REABSORCIÓN TUBULAR DE FOSFATO', 'RTFOS', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (246, '0398', 34, 'REABSORCION TUBULAR DE POTASIO', 'RTK', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (247, '0399', 34, 'FOSFORO EN SEGUNDA ORINA', 'P2AO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (248, '0400', 34, 'FOSFORO EN ORINA DE 24 HORAS', 'P24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (249, '0401', 13, 'PH EN ORINA', 'pHOr', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (250, '0402', 18, 'PH EN HECES', 'pHhec', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (251, '0403', 34, 'REL CALCIO/CREATININA ORINA 24H', 'CAC24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (252, '0404', 34, 'REL CALCIO/CREATININA SEGUNDA ORINA', 'CAC2A', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (253, '0405', 34, 'REL AC URICO/CREA SEGUNDA ORINA', 'AUC2A', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (254, '0406', 34, 'REL AC URICO/CREATININA EN ORINA', 'AUCOP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (255, '0407', 34, 'REL AC URICO/CREATININA EN 24H', 'AUC24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (256, '0408', 34, 'REL ALBUMINA/CREATININA ORINA', 'ALCRO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (257, '0409', 34, 'REL CITRATO/CREATININA (PARCIAL)', 'RCCRP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (258, '0410', 34, 'REL FOSFORO/CREAT ORINA 24H', 'PCR24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (259, '0411', 34, 'REL MAGNESIO/CREATININA', 'MGCR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (260, '0412', 34, 'REL OXALATO/CREATININA', 'OXCR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (261, '0413', 34, 'CURVA GLUCOSA 0, 30, 60 MIN', 'CTG2', 10.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (262, '0414', 34, 'CURVA GLUCOSA 0, 30, 120 MIN', 'CTG3', 10.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (263, '0415', 34, 'CURVA GLUCOSA 0, 30, 60, 180 MIN', 'CTG4', 13.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (264, '0416', 34, 'CURVA GLUCOSA 0, 30,60,120,180 MIN', 'CTG5', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (265, '0417', 34, 'CURVA GLUCOSA 0, 30,60,90,120 MIN', 'CTG6', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (266, '0418', 34, 'CURVA GLUCOSA 0, 60, 120 MIN', 'CTG7', 10.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (267, '0425', 15, 'CURVA INSULINA 0,30,120 MIN', 'CIN1', 46.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (268, '0426', 15, 'CURVA INSULINA 0,30,60,120 MIN', 'CIN2', 61.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (269, '0427', 15, 'CURVA INSULINA 0,60,120 MIN', 'CIN3', 46.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (270, '0428', 15, 'CURVA INSULINA 0,60,90,120 MIN', 'CIN4', 49.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (271, '0429', 15, 'CURVA INSULINA 0,60,120,180 MIN', 'CIN5', 61.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (272, '0430', 15, 'CURVA INSULINA 0,60,120,180,240\'', 'CIN6', 76.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (273, '0431', 15, 'CURVA INSULINA 0,30,60.', 'CIN7', 46.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (274, '0434', 34, 'CURVA GLUCOSA 0,30,60,120 MIN', 'CT1', 13.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (275, '0435', 34, 'FOSFORO EN ORINA DE DOS HORAS', 'P-O2H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (276, '0436', 34, 'GLICEMIA POSTCARGA', '', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (277, '0437', 34, 'GLICEMIA BASAL - POSTPRANDIAL', '', 7.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (278, '0438', 27, 'CARGA GLUCOSADA', 'CGLU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (279, '0439', 11, 'HEMATOLOGIA COMPLETA Y PLAQUETAS', 'HCYP', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (280, '0440', 15, 'INSULINA BASAL Y POSTPRANDIAL', 'INSBP', 32.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (281, '0441', 34, 'MAGNESIO EN ORINA DE 24 HORAS', 'MG24H', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (282, '0442', 34, 'REL CITRATO/CREATININA 24H', 'RCC24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (283, '0443', 34, 'AMILASA EN LIQUIDO ABDOMINAL', 'AMLAB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (284, '0444', 34, 'AMILASA EN LIQUIDO PERITONEAL', 'AMLPE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (285, '0445', 34, 'ACIDO URICO NO DISOCIADO', 'AUND', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (286, '0446', 15, 'ANTICUERPOS ANTITIROIDEOS', 'ANTIR', 15.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (287, '0447', 15, 'ANTICUERPOS PARA AMIBAS', 'AMIB', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (288, '0448', 22, 'B.K. CONCENTRADO', 'BKCON', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (289, '0449', 22, 'B.K. DIRECTO', 'BKDIR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (290, '0450', 22, 'B.K. EN ORINA', 'BKORI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (291, '0451', 22, 'B.K. DE ESPUTO', 'BKESP', 11.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (292, '0452', 22, 'B.K. EN ORINA - SERIADO', 'BKSER', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (293, '0453', 20, 'B2 MICROGLOBULINAS', 'B2MIC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (294, '0454', 34, 'ALBUMINA EN LIQUIDO PERITONEAL', 'ALBLP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (295, '0455', 15, 'ANTICUERPOS ANTIPEROXIDASA', 'ANPOD', 15.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (296, '0456', 15, 'ANTICUERPOS ANTI INSULINA', 'ANTIN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (297, '0457', 34, 'DEPURACION DE CREATININA NIÑOS', 'DNIÑ', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (298, '0458', 34, 'EXCRECIÓN FRACCIONADA ACIDO URICO', 'EXAU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (299, '0459', 34, 'EXCRECION FRACCIONADA DE CALCIO', 'EFCA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (300, '0460', 34, 'EXCRECION FRACCIONADA DE FOSFATO', 'EFP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (301, '0461', 34, 'EXCRECION FRACCIONADA DE POTASIO', 'EFK', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (302, '0462', 34, 'EXCRECION FRACCIONADA DE SODIO-FENA', 'FENA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (303, '0463', 36, 'GASES ARTERIALES', 'GART', 51.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (304, '0464', 34, 'GLUCOSA EN LIQUIDO CEFALORRAQUIDEO', 'GLLCR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (305, '0465', 34, 'GLUCOSA EN LIQUIDO PERITONEAL', 'GLLP', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (306, '0466', 22, 'GRAM', 'GRAM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (307, '0467', 11, 'HEMOGLOBINA - HEMATOCRITO', 'HEHE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (308, '0468', 34, 'PERFIL DE LITIASIS', '', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (309, '0470', 34, 'PYLORISET (HELICOBACTER PYLORI)', 'PYSET', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (310, '0471', 16, 'T.T. TIEMPO DE TROMBINA', 'TT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (311, '0472', 34, 'TRANSAMINASAS (TGO-TGP)', '', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (312, '0473', 34, 'UREA - CREATININA', 'UR-CR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (313, '0474', 17, 'A.N.A. (BLOT)', 'BLOT', 16.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (314, '0475', 15, 'ADENOVIRUS EN MOCO NASAL', 'ADMN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (315, '0477', 19, 'ANTI HBE', 'ANHBE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (316, '0479', 19, 'ANTICUERPOS C. ANTIG. DE SUPERFICIE', 'ANTAU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (317, '0480', 34, 'BALANCE METABOLICO OSEO', 'BMO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (318, '0481', 15, 'C.T.X.', 'CTX', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (319, '0482', 34, 'CALCIO - FOSFORO', 'CA-P', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (320, '0483', 15, 'CATECOLAMINAS EN ORINA DE 24 HORAS', 'CAT24', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (321, '0484', 15, 'CATECOLAMINAS EN SANGRE', 'CATS', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (322, '0486', 34, 'CREATININA EN LIQUIDO', 'CRELI', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (323, '0487', 34, 'CREATININA EN LIQUIDO PERITONEAL', 'CRELP', 6.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (324, '0488', 18, 'CRYPTOSPORIDIUM/GIARDIA/ENTAMOEBA H', 'BICHO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (325, '0489', 34, 'CUERPOS CETONICOS EN ORINA', 'CTORI', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (326, '0490', 34, 'CUERPOS CETONICOS EN SANGRE', 'CTSAN', 5.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (327, '0491', 22, 'CULTIVO HONGOS', 'HONGO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (328, '0493', 15, 'DI HIDRO TESTOSTERONA', 'DHT', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (329, '0494', 15, 'DIMERO D', 'DIMD', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (330, '0495', 11, 'DREPANOCITOS', 'DREPA', 8.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (331, '0496', 34, 'ELECTROLITOS EN AGUA', 'ELH2O', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (332, '0497', 15, 'EOSINOFILOS EN MOCO NASAL', 'EOMN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (333, '0499', 22, 'ESTUDIO BACT. DESINFECTANTE', 'BACDE', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (334, '0501', 15, 'ESTUDIO CALCULO URINARIO', 'CALUR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (335, '0502', 34, 'ESTUDIO DE LIQUIDO', 'LIQ', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (336, '0503', 22, 'ESTUDIO DIRECTO PARA ECTOPARASITOS', 'ECTO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (337, '0504', 11, 'GLOBULOS ROJOS', 'GLROJ', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (338, '0505', 15, 'GOTA GRUESA', 'GGRU', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (339, '0506', 15, 'H.C.G. BETA CUANTITATIVA', 'HCGEM', 9.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (340, '0507', 18, 'HECES (II)', 'HECII', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (341, '0508', 18, 'HECES (III)', 'HEIII', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (342, '0509', 19, 'HEPATITIS A (IGG-IGM)', 'HEPA', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (343, '0510', 15, 'HERPES (IGG-IGM)', 'HERP', 31.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (344, '0512', 17, 'ANTI CARDIOLIPINAS (IGG-IGM)', 'ANTIC', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (345, '0513', 35, 'CHLAMYDIA PNEUMONIAE (IGG-IGM)', 'CHPH', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (346, '0514', 35, 'CHLAMYDIA TRACHOMATIS (IGG-IGM)', 'CHTR', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (347, '0516', 35, 'CITOMEGALOVIRUS (IGG-IGM)', 'CITO', 22.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (348, '0518', 35, 'MYCOPLASMA PNEUMONIAE (IGG-IGM)', 'MYPN', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (349, '0519', 15, 'RUBEOLA (IGG-IGM)', 'RUBEO', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (350, '0520', 35, 'EPSTEIN BARR (IGG-IGM)', 'EBV', 21.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (351, '0521', 15, 'ERLICHIA (IGG-IGM)', 'ERLI', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (352, '0522', 15, 'ERLICHIA (IGG)', 'ERIGG', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (353, '0523', 15, 'ERLICHIA (IGM)', 'ERIGM', 0.00, 1, '2025-11-25 21:55:02', '2025-11-25 21:55:02');
INSERT INTO `lab_exams` VALUES (354, '0524', 15, 'PAROTIDITIS (IGG)', 'PARIG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (355, '0525', 15, 'PAROTIDITIS (IGM)', 'PARIM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (356, '0526', 15, 'PAROTIDITIS (IGG-IGM)', 'PAROT', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (357, '0528', 35, 'CHLAMYDIA TRACHOMATIS (IGA)', 'CHTA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (358, '0530', 11, 'INDICES HEMATIMETRICOS', 'INHEM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (359, '0531', 34, 'INFLUENZA EN MOCO NASAL', 'INFMN', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (360, '0532', 15, 'INFLUENZA (IGM)', 'INFGM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (361, '0533', 15, 'INFLUENZA (IGG)', 'INFGG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (362, '0534', 15, 'INFLUENZA (IGG-IGM)', 'INFGM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (363, '0535', 13, 'INVESTIGACION AG. CAPSULARES ORINA', 'ACAPO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (364, '0536', 15, 'INVESTIGACION AG. CAPSULARES', 'AGCAP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (365, '0537', 18, 'INVESTIGACION CRYPTOSPORIDIUM SP', 'CRYP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (366, '0538', 27, 'KIT BACTERIOLOGIA', 'KBACT', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (367, '0539', 27, 'KIT DE SUMINISTROS', 'SUMIN', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (368, '0540', 22, 'KIT HEMOCULTIVO (1)', 'HEMO1', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (369, '0541', 22, 'KIT HEMOCULTIVO (2)', 'HEMO2', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (370, '0542', 22, 'KIT HEMOCULTIVO (3)', 'HEMO3', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (371, '0543', 34, 'LIQUIDO ARTICULAR', 'LART', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (372, '0544', 34, 'LIQUIDO ASCITICO', 'LASC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (373, '0545', 34, 'LIQUIDO CEFALORRAQUIDEO', 'LCR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (374, '0546', 34, 'LIQUIDO DE OSTOMIA', 'LOST', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (375, '0547', 34, 'LIQUIDO DE PUNCION RENAL', 'LPR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (376, '0548', 34, 'LIQUIDO DE SECRECION NASAL', 'LSN', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (377, '0549', 34, 'LIQUIDO PERICARDICO', 'LPERI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (378, '0550', 34, 'LIQUIDO PERITONEAL', 'LPERT', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (379, '0551', 34, 'LIQUIDO PLEURAL', 'PLEU', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (380, '0552', 34, 'LIQUIDO SECRECION DE HERIDA', 'HERID', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (381, '0553', 34, 'LIQUIDO SINOVIAL', 'SINOV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (382, '0554', 34, 'LIQUIDO SUBDURAL', 'SUBDU', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (383, '0555', 34, 'LIQUIDO TUMOR REGION CELLAR', 'TUMO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (384, '0556', 34, 'MICROALBUMINURIA', 'MICRO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (385, '0557', 34, 'MICROALBUMINURIA EN ORINA PARCIAL', 'MICOR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (386, '0558', 20, 'NSE', 'NSE', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (387, '0559', 15, 'PERFIL VIRAL RESPIRATORIO', 'PVR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (388, '0560', 16, 'P.T. CORREGIDO', 'PTCOR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (389, '0561', 16, 'P.T./INR', 'PTINR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (390, '0562', 16, 'P.T.T. CORREGIDO', 'PTTCO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (391, '0564', 15, 'SARAMPION (IGG-IGM)', 'SARGM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (392, '0565', 15, 'SARAMPION (IGG)', 'SARG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (393, '0566', 15, 'SARAMPION (IGM)', 'SARM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (394, '0567', 14, 'PROTEINA C REACTIVA (PCR)', 'AMEB', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (395, '0568', 22, 'TINTA CHINA', 'CHINA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (396, '0569', 27, 'TOMA DE MUESTRA', 'MUEST', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (397, '0570', 27, 'TOMA DE MUESTRA CON MATERIAL (4)', 'MUES4', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (398, '0571', 27, 'TOMA DE MUESTRA CON MATERIAL (6)', 'MUES6', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (399, '0572', 34, 'UREA-CREATININA EN LIQ DE PORTO-VAC', 'UCLPV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (400, '0574', 15, 'VITAMINA D', 'VITD', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (401, '0575', 13, 'ORINA', 'ORINA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (402, '0576', 15, 'CONTAJE BLANCO EN LIQ. DE DIÁLISIS', 'CBLD', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (403, '0577', 11, 'CONTAJE BLANCO EN LIQ. PERITONEAL', 'CBLP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (404, '0578', 15, 'CORTISOL A.M. - P.M.', 'CORT', 22.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (405, '0579', 34, 'DENSIDAD EN LÍQUIDO', 'DLIQ', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (406, '0580', 34, 'DET. GONADOTROFINA HUMANA (ORINA)', 'GONOR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (407, '0581', 34, 'DET. GONADOTROFINA HUMANA (SANGRE)', 'GONSA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (408, '0582', 15, 'SANGRE OCULTA EN CONT. GÁSTRICO', 'SOCG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (409, '0583', 15, 'VIRUS SINCITIAL RESPIRATORIO', 'VSRES', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (410, '0584', 15, 'VIRUS SINCITIAL MOCO NASAL', 'VSMN', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (411, '0585', 17, 'ANTI FOSFOLÍPIDOS (IGM - IGG)', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (412, '0586', 17, 'B2 GLICOPROTEINAS (IGM-IGG)', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (413, '0587', 13, 'ORINA (II)', 'ORI2', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (414, '0588', 13, 'ORINA (III)', 'ORI3', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (415, '0589', 15, 'TESTOSTERONA TOTAL Y LIBRE', 'TESTL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (416, '0590', 15, 'A.C.T.H.', 'ACTH', 21.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (417, '0591', 15, 'ANTICUERPOS ANTITIROGLOBULÍNICOS', 'TIROG', 15.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (418, '0592', 34, 'C.P.K. FOSFO-QUINASA CREATINA', 'CPK', 10.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (419, '0593', 18, 'DETERMINACIÓN DE H. PYLORI EN HECES', 'HPYLH', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (420, '0594', 37, 'T3 TOTAL Y LIBRE', 'T3TYL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (421, '0595', 37, 'T4 TOTAL Y LIBRE', 'T4TYL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (422, '0597', 18, 'ADENOVIRUS', 'ADENO', 11.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (423, '0598', 23, 'V.P.H.', 'VPH', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (424, '0599', 23, 'RT PCR COVID19', 'COVI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (425, '0600', 23, 'PCR EPSTEIN BARR', 'EBV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (426, '0601', 23, 'PCR CITOMEGALOVIRUS', 'CMV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (427, '0602', 23, 'V.P.H. BIOPSIA', 'VPHB', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (428, '0603', 38, 'SARS COVID-2 ANTÍGENO', 'C19A', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (429, '0604', 38, 'COVID-19 IGM/IGG', 'COV', 40.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (430, '0605', 38, 'COVID-19 ANTICUERPOS NEUTRALIZANTES', 'CANN', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (431, '0606', 39, 'PANEL DE ALIMENTOS INTERNACIONAL', 'ALIM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (432, '0607', 39, 'PANEL RESPIRATORIO', 'RESP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (433, '0608', 39, 'PERFIL CELÍACO IGA', 'CELI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (434, '0609', 39, 'PERFIL CELIACO IGG', 'CELG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (435, '0610', 18, 'CALPROTECTINA', 'CALP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (436, '0611', 23, 'MULTIPLEX I (INFERTILIDAD)', 'PLEX', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (437, '0612', 23, 'MULTIPLEX II (NEUMONIAS ATIPICAS)', 'PLX2', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (438, '0613', 23, 'MULTIPLEX III (MENINGITIS VIRAL)', 'PLX3', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (439, '0614', 23, 'MULTIPLEX IV (VIRUS RESPIRATORIO)', 'PLX4', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (440, '0615', 23, 'MULTIPLEX VII (MENINGITIS BACT)', 'PLX7', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (441, '0616', 23, 'MULTIPLEX VIII (HERPES VIRUS)', 'PLX8', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (442, '0617', 23, 'PCR DENGUE', 'DENG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (443, '0618', 23, 'PCR TORCH', 'TRCH', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (444, '0619', 23, 'PCR HIV', 'HIVP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (445, '0620', 23, 'PCR HERPES', 'HERP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (446, '0621', 23, 'PCR HEPATITIS B', 'HEPB', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (447, '0622', 23, 'PCR HEPATITIS C', 'HEPC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (448, '0623', 15, 'ALDOSTERONA', 'ALDO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (449, '0624', 15, 'ESTROGENOS TOTALES', 'ESTR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (450, '0625', 15, '5 HIDROXINDOL ACETICO ORINA 24H', 'HIDR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (451, '0626', 38, 'SARS COVID-2 ANTIGENO CUANT', 'COV2', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (452, '0627', 34, 'ANION GAP URINARIO', 'GAPUR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (453, '0628', 15, 'DENGUE NS1', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (454, '0629', 15, 'ELECTROFRESIS DE COLESTEROL', 'ELCOL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (455, '0630', 15, 'ELECTROFORESIS DE HEMOGLOBINA', 'ELHEM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (456, '0631', 15, 'ELECTROFORESIS DE PROTEINAS', 'ELPRO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (457, '0632', 13, 'OSMOLARIDAD URINARIA', 'OSMOL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (458, '0634', 15, 'HORMONA ANTIMULERIANA', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (459, '0636', 39, 'PANEL CELIACO IGA', 'pceli', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (460, '0637', 39, 'PANEL CELIACO IGG', 'pigg', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (461, '0638', 23, 'PCR TOXOPLASMOSIS', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (462, '0639', 34, 'T.I.B.C.', 'TIBC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (463, '0640', 15, 'INTERLUQUINA (IL-6)', 'inter', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (464, '0641', 38, 'ANTICUERPOS CUANT. IGM IGG COVID-19', 'ACC', 40.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (465, '0642', 15, 'SHBG', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (466, '0643', 34, 'PROTEINURIA EN ORINA DE 2H', 'PR2H', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (467, '0644', 15, 'DHEA', 'DHEA', 16.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (468, '0645', 23, 'PCR ERLICHIA', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (469, '0646', 15, 'METANEFRINAS EN SANGRE', 'META', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (470, '0647', 17, 'ANCA C', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (471, '0648', 17, 'ANCA P', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (472, '0649', 17, 'ANTI BETA 2 GLICOPROTEINA IGM', 'ab2ig', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (473, '0650', 23, 'FACTOR II (PROTOMBINA)', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (474, '0651', 23, 'FACTOR V (LEIDEN)', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (475, '0652', 23, 'CELULAS NK', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (476, '0653', 23, 'INMUNOFENOTIPEAJE CD3/CD4/CD8', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (477, '0655', 15, 'PROTEINA C ULTRA SENSIBLE', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (478, '0656', 23, 'PCR MUTACIN MTHFR A1298C', '1298c', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (479, '0657', 23, 'PCR MUTACIÓN MTHFR C677T', '677T', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (480, '0658', 15, 'AMONIO', 'AMONI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (481, '0659', 23, 'PCR BRUCELLA', 'BRUCE', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (482, '0660', 22, 'CULTIVO ANAEROBIOS', 'ANAER', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (483, '0661', 22, 'CULTIVO MICOBACTERIAS', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (484, '0662', 15, 'NT-PROBNP', 'pronp', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (485, '0664', 15, 'GALACTOMANANO', 'GALAC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (486, '0665', 39, 'PANEL HÍGADO RIÑÓN', 'HIGRI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (487, '0666', 39, 'PANEL DE ALIMENTOS VENEZUELA', 'ALVZL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (488, '0667', 23, 'PCR MYCOBACTERIUM TUBERCULOSIS', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (489, '0668', 15, 'DIGOXINA', 'DIG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (490, '0669', 23, 'PCR ONCOGENES', 'ONC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (491, '0670', 11, 'RETICULOCITOS', 'RETIC', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (492, '0671', 23, 'HLA-B27', 'HLAB2', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (493, '0672', 15, 'TACROLIMUS', 'TACRO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (494, '0673', 23, 'TROMBOFILIA (PERFIL)', 'TROMB', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (495, '0674', 13, 'OSMOLALIDAD URINARIA', 'OSMOL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (496, '0675', 38, 'COVID,INFL,VSR, ADENO,PNEU HISOPADO', 'CIAVP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (497, '0676', 23, 'LINFOCITOS CD3 / CD4 / CD8', 'CD348', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (498, '0677', 15, 'CADENAS LIGERAS KAPPA', 'KAPPA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (499, '0678', 15, 'CADENAS LIGERAS LAMBDA', 'LAMBD', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (500, '0679', 20, 'BETA 2 MICROGLOBULINAS EN ORINA', 'BMG O', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (501, '0680', 15, 'ÁCIDO VANILMANDÉLICO EN ORINA 24H', 'AVO24', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (502, '0681', 18, 'CLOSTRIDIUM DIFFICILE ANTIG. HECES', 'CLOST', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (503, '0682', 18, 'SALMONELLA TYPHI Y PARATYPHI ANTIG.', 'SALMO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (504, '0683', 39, 'PANEL MIXTO ATOPICOS', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (505, '0684', 34, 'CALCIO IÓNICO', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (506, '0685', 14, 'DENGUE IGG, IGM, NS1.', 'DENG', 21.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (507, '0686', 20, 'HE4', 'HE4', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (508, '0687', 23, 'CARGA VIRAL DE HIV', 'CV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (509, '0688', 15, 'COBRE', 'COBRE', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (510, '0689', 15, 'MERCURIO', 'MERCU', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (511, '0690', 15, 'CERULOPLASMINA', 'CERUL', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (512, '0691', 30, 'HEMOCULTIVO 2', 'HEMO2', 26.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (513, '0692', 30, 'HEMOCULTIVO 3', 'HEMO3', 26.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (514, '0693', 15, 'TUBERCULOSIS IGRA', 'TIGRA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (515, '0694', 23, 'PCR ZIKA', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (516, '0695', 19, 'ANTI CORE IGG', 'COREG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (517, '0696', 15, 'METANEFRINAS EN ORINA DE 24 HORAS', 'METAO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (518, '0697', 15, 'ANTI SMITH (SM)', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (519, '0698', 17, 'ANTI-RO (SSA)', 'ANTRO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (520, '0699', 17, 'ANTI-LA (SSB)', 'ANTLA', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (521, '0700', 23, 'PARVOVIRUS B19 / ERYTHROVIRUS', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (522, '0701', 15, 'GASTRINA', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (523, '0702', 34, 'RELACION CITRATO / CREAT. 2DA ORINA', 'CITCR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (524, '0703', 34, 'RELACION OXALATO / CREAT. 2DA ORINA', 'OXACR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (525, '0704', 34, 'RELACION CALCIO / CITRATO 2DA ORINA', 'CACIT', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (526, '0705', 15, 'ANTICOAGULANTE LUPICO', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (527, '0706', 17, 'ANTICUERPOS ANTI JO-1', 'ANTJO', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (528, '0707', 34, 'OSMOLARIDAD PLASMÁTICA', 'OSMP', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (529, '0708', 23, 'CARGA VIRAL DE HEPATITIS C', 'CVHCV', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (530, '0709', 39, 'PANEL IGG 4 NUTRICIONAL  VE1', 'IGGVE', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (531, '0710', 39, 'PANEL IGG NUTRICIONAL 24 ELISA', 'IGG24', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (532, '0711', 28, 'SODIO Y POTASIO', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (533, '0712', 14, 'H.I.V.', 'SEHI', 4.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (534, '0713', 14, 'V.D.R.L.', 'SEVDR', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (535, '0714', 14, 'PRUEBA DE EMBARAZO (H.C.G.)', 'SEHCG', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (536, '0715', 14, 'TOXOPLASMOSIS IGM', 'SEIGM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (537, '0716', 14, 'HEPATITIS A', 'SEHEP', 5.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (538, '0717', 14, 'HEPATITIS B (HBAGS)', 'SEHBB', 6.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (539, '0718', 14, 'HEPATITIS B (HBCORE)', 'SEHBC', 6.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (540, '0719', 14, 'HEPATITIS C  (HCV)', 'SEHCV', 5.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (541, '0720', 14, 'DENGUE IGG', 'SEGDI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (542, '0721', 14, 'DENGUE IGM', 'SEDGM', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (543, '0722', 28, 'CLORO', 'cl', 4.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (544, '0723', 28, 'POTASIO', 'k', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (545, '0724', 28, 'SODIO', 'Na +', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (546, '0725', 11, 'PERFIL 20', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (547, '0726', 18, 'HELICOBACTER PYLORI EN HECES', 'HPylo', 11.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (548, '0727', 15, 'COLINESTERASA', '', 11.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (549, '0728', 15, 'PRUEBA ESPECIAL C', 'COCAI', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (550, '0729', 15, 'PRUEBA ESPECIAL M', 'MARIH', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (551, '0730', 15, 'PRUEBA ESPECIAL H', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (552, '0731', 15, 'PRUEBA ESPECIAL V', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (553, '0732', 34, 'GLICEMIA BASAL POST-CARGA 60 Y 120', '', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (554, '0733', 15, 'PRUEBA ESPECIAL E', 'H.C.G', 0.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (555, '0734', 15, 'HIV (ELISA DE 4TA GENERACION)', '', 11.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');
INSERT INTO `lab_exams` VALUES (556, '0735', 14, 'LEPTOSPIRA (IGG-IGM)', 'LEPTO', 21.00, 1, '2025-11-25 21:55:03', '2025-11-25 21:55:03');

-- ----------------------------
-- Table structure for lab_order_details
-- ----------------------------
DROP TABLE IF EXISTS `lab_order_details`;
CREATE TABLE `lab_order_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `lab_order_id` bigint UNSIGNED NOT NULL,
  `lab_exam_id` bigint UNSIGNED NOT NULL,
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lab_order_details_lab_order_id_foreign`(`lab_order_id`) USING BTREE,
  INDEX `lab_order_details_lab_exam_id_foreign`(`lab_exam_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of lab_order_details
-- ----------------------------
INSERT INTO `lab_order_details` VALUES (1, 3, 303, 51.00, 'pending', '2025-11-26 21:48:23', '2025-11-26 21:48:23');
INSERT INTO `lab_order_details` VALUES (2, 3, 166, 0.00, 'pending', '2025-11-26 21:48:23', '2025-11-26 21:48:23');
INSERT INTO `lab_order_details` VALUES (3, 4, 483, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (4, 4, 82, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (5, 4, 336, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (6, 4, 124, 16.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (7, 4, 75, 4.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (8, 4, 76, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (9, 4, 63, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (10, 4, 420, 0.00, 'completed', '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_order_details` VALUES (11, 5, 90, 11.00, 'completed', '2025-11-27 17:01:21', '2025-11-27 17:01:47');
INSERT INTO `lab_order_details` VALUES (12, 5, 93, 11.00, 'completed', '2025-11-27 17:01:21', '2025-11-27 17:01:47');

-- ----------------------------
-- Table structure for lab_orders
-- ----------------------------
DROP TABLE IF EXISTS `lab_orders`;
CREATE TABLE `lab_orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `patient_id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NULL DEFAULT NULL,
  `clinica_id` bigint UNSIGNED NULL DEFAULT NULL,
  `order_date` date NOT NULL,
  `sample_date` date NULL DEFAULT NULL,
  `result_date` date NULL DEFAULT NULL,
  `status` enum('pending','in_progress','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'pending',
  `total` decimal(10, 2) NULL DEFAULT 0.00,
  `observations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `verification_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED NULL DEFAULT NULL,
  `daily_exam_count` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number`) USING BTREE,
  UNIQUE INDEX `verification_code`(`verification_code`) USING BTREE,
  INDEX `patient_id`(`patient_id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id`) USING BTREE,
  INDEX `clinica_id`(`clinica_id`) USING BTREE,
  INDEX `created_by`(`created_by`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lab_orders
-- ----------------------------
INSERT INTO `lab_orders` VALUES (3, 'LAB-2025-000001', 21, NULL, 1, '2025-11-26', '2025-11-26', NULL, 'pending', 51.00, 'primera solicitud de laboratorio', NULL, 21, 1, '2025-11-26 21:48:23', '2025-11-26 21:48:23');
INSERT INTO `lab_orders` VALUES (4, 'LAB-2025-000002', 30, NULL, 1, '2025-11-27', '2025-11-27', '2025-11-27', 'completed', 20.00, 'PRUIEBA DE LABORATORIO', 'LDG6SMNOJACO', 21, 1, '2025-11-27 16:45:30', '2025-11-27 16:47:40');
INSERT INTO `lab_orders` VALUES (5, 'LAB-2025-000003', 31, NULL, 1, '2025-11-27', '2025-11-27', '2025-11-27', 'completed', 22.00, NULL, '47MDWGDGMGBE', 21, 2, '2025-11-27 17:01:21', '2025-11-27 17:01:47');

-- ----------------------------
-- Table structure for lab_reference_groups
-- ----------------------------
DROP TABLE IF EXISTS `lab_reference_groups`;
CREATE TABLE `lab_reference_groups`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` tinyint UNSIGNED NOT NULL,
  `age_start_day` int NOT NULL DEFAULT 0,
  `age_start_month` int NOT NULL DEFAULT 0,
  `age_start_year` int NOT NULL DEFAULT 0,
  `age_end_day` int NOT NULL DEFAULT 0,
  `age_end_month` int NOT NULL DEFAULT 0,
  `age_end_year` int NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `lab_reference_groups_code_unique`(`code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_reference_groups
-- ----------------------------
INSERT INTO `lab_reference_groups` VALUES (1, 'M002', 'INFANTES', 3, 0, 1, 0, 0, 12, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (2, 'M003', 'NEONATOS', 3, 1, 0, 0, 2, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (3, 'M004', 'HOMBRES', 1, 1, 0, 0, 0, 0, 150, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (4, 'M005', 'MUJERES', 2, 1, 0, 0, 0, 0, 150, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (5, 'M010', 'NIÑOS', 3, 0, 0, 1, 0, 0, 13, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (6, 'M017', 'VALOR1-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (7, 'M018', 'VALOR2-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (8, 'M019', 'VALOR3-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (9, 'M021', 'VALOR4-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (10, 'M022', 'VALOR5-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (11, 'M023', 'ADULTOS', 3, 0, 0, 14, 0, 0, 150, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (12, 'M024', 'RECIEN NACIDOS', 3, 3, 0, 0, 30, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (13, 'M025', 'VALOR6-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (14, 'M026', 'VALOR1-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (15, 'M027', 'VALOR2-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (16, 'M028', 'VALOR3-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (17, 'M029', 'VALOR4-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (18, 'M030', 'VALOR1-MASC', 1, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (19, 'M031', 'VALOR2-MASC', 1, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (20, 'M032', 'VALOR3-MASC', 1, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (21, 'M033', 'VALOR4-MASC', 1, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (22, 'M034', 'VALOR7-TODOS', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (23, 'M035', 'VALOR5-MASC', 1, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (24, 'M036', 'VALOR5-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (25, 'M037', 'VALOR6-FEME', 2, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (26, 'M038', 'NIÑOS-01', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (27, 'M039', 'NIÑOS-02', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (28, 'M040', 'NIÑOS-03', 3, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_groups` VALUES (29, 'M041', 'NIÑOS-04', 0, 0, 0, 0, 0, 0, 0, 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');

-- ----------------------------
-- Table structure for lab_reference_ranges
-- ----------------------------
DROP TABLE IF EXISTS `lab_reference_ranges`;
CREATE TABLE `lab_reference_ranges`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `lab_exam_item_id` bigint UNSIGNED NOT NULL,
  `lab_reference_group_id` bigint UNSIGNED NOT NULL,
  `condition` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `value_min` decimal(10, 2) NULL DEFAULT NULL,
  `value_max` decimal(10, 2) NULL DEFAULT NULL,
  `value_text` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lab_reference_ranges_lab_exam_item_id_foreign`(`lab_exam_item_id`) USING BTREE,
  INDEX `lab_reference_ranges_lab_reference_group_id_foreign`(`lab_reference_group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 688 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_reference_ranges
-- ----------------------------
INSERT INTO `lab_reference_ranges` VALUES (1, 48, 6, '', 1.50, 7.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (2, 211, 6, '', 2.00, 8.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (3, 80, 6, '', NULL, 9.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (4, 213, 6, '<', 1.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (5, 267, 6, 'NEGATIVO <', 0.90, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (6, 215, 6, '<', 20.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (7, 218, 6, 'HASTA', 12.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (8, 219, 6, '<', 11.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (9, 263, 6, 'NO DETECTABLE <', 0.90, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (10, 269, 6, '', 0.10, 74.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (11, 87, 6, 'HASTA', 40.00, NULL, 'METODO: ELISA', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (12, 183, 6, 'NORMAL <', 5.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (13, 221, 6, '>', 18.10, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (14, 201, 6, 'Hasta', 1.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (15, 202, 6, 'Hasta', 0.20, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (16, 203, 6, 'Hasta', 0.80, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (17, 58, 6, '', 0.90, 1.80, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (18, 162, 6, '', 0.10, 0.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (19, 74, 6, '<', 35.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (20, 96, 6, 'HASTA', 35.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (21, 72, 6, 'NORMAL <', 37.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (22, 73, 6, 'HASTA', 5.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (23, 49, 6, 'NIÑOS', 9.00, 11.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (24, 223, 6, '', 42.20, 353.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (25, 59, 6, '', 101.00, 300.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (26, 148, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (27, 227, 6, '', NULL, 170.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (28, 56, 6, '', NULL, 25.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (29, 175, 6, '>=', 45.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (30, 197, 6, '<', 150.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (31, 47, 6, 'HASTA', 200.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (32, 198, 6, 'Hasta', 200.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (33, 199, 6, '', 30.00, 70.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (34, 200, 6, '', NULL, 100.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (35, 194, 6, '', NULL, 3.03, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (36, 194, 7, '', 0.30, 1.00, 'Fase folicular', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (37, 194, 8, '', 0.20, 2.90, 'Fase Luteal', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (38, 271, 6, '', 250.00, 400.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (39, 228, 6, '', 20.00, 150.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (40, 256, 6, '', 50.00, 230.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (41, 229, 6, '', 9.00, 53.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (42, 46, 6, '', 0.50, 1.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (43, 231, 6, '<', 6.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (44, 260, 6, '', 135.00, 150.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (45, 261, 6, '', 3.50, 5.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (46, 262, 6, '', 92.00, 110.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (47, 54, 6, '', 10.00, 20.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (48, 281, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (49, 280, 6, '', 15.00, 45.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (50, 62, 6, '<', 3.50, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (51, 265, 6, '', 1.00, 15.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (52, 276, 6, '', NULL, 5.00, 'No embarazo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (53, 276, 7, '', 5.80, 71.20, '(3 SEMANAS)', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (54, 276, 8, '', 9.50, 750.00, '(4 SEMANAS)', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (55, 276, 9, '', 217.00, 7138.00, '(5 SEMANAS)', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (56, 156, 6, '<', 2.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (57, 156, 7, '>', 2.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (58, 157, 6, '<', 2.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (59, 157, 7, '>', 2.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (60, 69, 6, '', 45.00, 300.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (61, 287, 6, '', 0.70, 4.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (62, 60, 6, '', 7.00, 16.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (63, 61, 6, '', 0.40, 2.30, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (64, 147, 6, '', 2.26, 24.19, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (65, 277, 6, 'Hasta', NULL, 190.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (66, 51, 6, 'ADULTOS', 1.30, 2.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (67, 95, 6, '', 0.80, 1.20, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (68, 251, 6, '', 0.90, 4.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (69, 169, 6, 'Hasta', 180.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (70, 171, 6, '<', 150.00, NULL, '0', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (71, 173, 6, '', 30.00, 150.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (72, 181, 3, '', 0.27, 9.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (73, 181, 14, 'MUJER', 0.20, 0.70, 'PRE-PUBERTAD', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (74, 181, 15, '', 0.15, 0.70, 'FASE FOLICULAR', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (75, 181, 16, '', 2.00, 25.00, 'FASE LUTEA', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (76, 52, 6, '', 6.30, 8.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (77, 53, 6, '', 3.50, 5.10, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (78, 249, 6, '', 42.00, 225.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (79, 288, 6, '<', NULL, 1.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (80, 122, 6, '<', 4.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (81, 144, 6, 'HASTA', 4.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (82, 191, 6, 'HASTA', 1.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (83, 247, 6, '', 10.00, 65.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (84, 286, 6, 'ADULTOS', 0.15, 0.76, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (85, 244, 6, '<', 24.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (86, 143, 6, '<', 2.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (87, 243, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (88, 243, 7, '', 0.90, 1.10, 'Sospechoso', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (89, 243, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (90, 83, 6, '', 2.80, 7.10, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (91, 70, 6, '', 0.60, 1.85, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (92, 71, 6, '', 12.00, 22.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (93, 242, 7, '', 1.00, 7.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (94, 91, 6, 'HASTA', 50.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (95, 97, 6, '', 10.00, 40.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (96, 240, 6, '', 15.00, 30.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (97, 82, 6, 'RECIEN NACIDOS', 160.00, 1300.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (98, 304, 6, 'Hasta', 30.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (99, 303, 6, '', 20.00, 55.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (100, 309, 18, 'Hasta', 3.40, NULL, '1/2 promedio', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (101, 309, 19, 'Hasta', 4.97, NULL, '1 promedio', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (102, 309, 20, 'Hasta', 9.53, NULL, '2 promedios', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (103, 309, 21, 'Hasta', 23.39, NULL, '3 promedios', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (104, 309, 14, 'Hasta', 3.27, NULL, '1/2 promedio', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (105, 309, 15, 'Hasta', 4.44, NULL, '1 promedio', 7, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (106, 309, 16, 'Hasta', 9.05, NULL, '2 promedios', 8, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (107, 309, 17, 'Hasta', 23.39, NULL, '3 promedios', 9, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (108, 310, 18, 'Hasta', 1.00, NULL, '1/2 promedio', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (109, 310, 19, 'Hasta', 3.55, NULL, '1 promedio', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (110, 310, 20, 'Hasta', 6.20, NULL, '2 promedios', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (111, 310, 21, 'Hasta', 7.99, NULL, '3 promedios', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (112, 310, 14, 'Hasta', 1.47, NULL, '1/2 promedio', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (113, 310, 15, 'Hasta', 3.22, NULL, '1 promedio', 7, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (114, 310, 16, 'Hasta', 5.03, NULL, '2 promedios', 8, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (115, 310, 17, 'Hasta', 7.99, NULL, '3 promedios', 9, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (116, 149, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (117, 149, 7, 'POSITIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (118, 55, 6, '', 4.00, 10.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (119, 125, 6, '', 0.14, 11.20, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (120, 181, 17, '', 0.06, 1.60, 'POST-MENOPAUSIA', 5, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (121, 181, 24, 'EMBARAZADA', 10.30, 44.00, 'Primer trimestre', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (122, 181, 13, '', 19.50, 82.50, 'Segundo trimestre', 8, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (123, 181, 22, '', 65.00, 229.00, 'Tercer trimestre', 9, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (124, 267, 7, 'SOSPECHOSO', 0.90, 1.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (125, 84, 11, 'Hasta', 6.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (126, 164, 6, '>', 1.10, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (127, 164, 7, '', 0.90, 1.10, 'BORDERLINA', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (128, 226, 6, '<', NULL, 1.00, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (129, 226, 7, '', 0.90, 1.10, 'BORDERLINE', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (130, 226, 8, '>', 1.10, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (131, 233, 3, 'HOMBRES', 100.00, 300.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (132, 233, 4, 'MUJERES', 19.00, 286.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (133, 281, 7, 'POSTIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (134, 234, 6, 'NEGATICO <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (135, 234, 7, 'POSITIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (136, 238, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (137, 238, 7, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (138, 216, 11, '<', 20.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (139, 313, 6, '', 315.00, 385.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (140, 289, 6, '<', 20.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (141, 213, 7, '<', 1.00, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (142, 214, 6, '<', 12.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (143, 214, 7, '>', 18.00, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (144, 164, 8, '<', 0.90, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (145, 305, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (146, 45, 6, '', 200.00, 400.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (147, 159, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (148, 276, 10, '', 158.00, 31795.00, '(6 SEMANAS)', 5, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (149, 276, 13, '', 3697.00, 163563.00, '(7 SEMANAS)', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (150, 276, 14, '', 63803.00, 151410.00, '(9 SEMANAS)', 8, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (151, 276, 15, '', 46509.00, 186977.00, '(10 SEMANAS)', 8, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (152, 276, 16, '', 27832.00, 210612.00, '(12 SEMANAS)', 9, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (153, 276, 22, '', 32065.00, 149571.00, '(8 SEMANAS)', 7, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (154, 222, 6, '>', 18.10, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (155, 168, 6, '', -6.00, 6.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (156, 41, 6, '', 150000.00, 450000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (157, 246, 6, 'Hasta', 0.20, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (158, 160, 6, '', 5.00, 25.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (159, 318, 6, 'HASTA', 200.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (160, 319, 6, 'HASTA', 165.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (161, 170, 6, '>=', 45.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (162, 320, 6, '', 3.50, 5.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (163, 322, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (164, 329, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (165, 336, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (166, 345, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (167, 356, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (168, 367, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (169, 378, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (170, 378, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (171, 378, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (172, 382, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (173, 382, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (174, 382, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (175, 387, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (176, 387, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (177, 387, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (178, 391, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (179, 391, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (180, 391, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (181, 395, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (182, 395, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (183, 395, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (184, 400, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (185, 400, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (186, 400, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (187, 406, 5, '<', 10.00, NULL, 'Hasta 12 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (188, 406, 11, '', 2.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (189, 406, 6, '<', 25.00, NULL, 'Diabeticos tipo II', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (190, 411, 6, '', 70.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (191, 420, 6, '', 4.00, 37.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (192, 426, 6, '', 50.00, 140.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (193, 429, 6, '', 50.00, 140.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (194, 432, 6, '', 4.00, 37.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (195, 439, 6, '', 250.00, 750.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (196, 442, 6, '<', 20.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (197, 443, 6, '<', 30.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (198, 454, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (199, 454, 7, '', 0.90, 1.10, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (200, 454, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (201, 455, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (202, 455, 7, '', 0.90, 1.10, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (203, 455, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (204, 456, 5, '', 140.00, 940.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (205, 456, 11, '', 320.00, 1240.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (206, 468, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (207, 502, 3, '', 200.00, 400.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (208, 523, 6, '<', 1000.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (209, 558, 6, '', 5.00, 25.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (210, 566, 6, '', 7.00, 14.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (211, 570, 6, 'HASTA', 225.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (212, 574, 6, '<', 11.20, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (213, 576, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (214, 578, 6, '', 3.30, 5.10, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (215, 580, 6, '', 85.00, 95.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (216, 588, 6, '', 0.40, 1.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (217, 591, 6, '', 0.40, 1.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (218, 595, 6, '', 0.40, 1.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (219, 596, 6, '<', 0.40, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (220, 606, 6, '<', 0.20, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (221, 627, 6, '<', 40.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (222, 628, 6, '<', 35.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (223, 642, 6, '<', 2.50, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (224, 644, 6, 'HASTA', 40.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (225, 670, 6, '<', 5.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (226, 692, 6, '', 2.50, 7.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (227, 694, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (228, 696, 11, '', 4.27, 10.23, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (229, 696, 6, '', 11.00, 17.00, 'Niños 1 - 7 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (230, 696, 7, '', 4.40, 10.00, 'Niños > 7 años', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (231, 701, 11, '', 6.78, 13.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (232, 701, 5, '', 5.19, 11.67, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (233, 710, 3, '', 14.00, 18.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (234, 710, 4, '', 12.00, 14.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (235, 715, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (236, 716, 6, '', 2.50, 7.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (237, 719, 6, '', 1.60, 2.60, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (238, 720, 6, '', 135.00, 150.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (239, 721, 6, '', 3.50, 5.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (240, 722, 6, '', 92.00, 110.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (241, 723, 6, '', 65.00, 300.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (242, 728, 6, '', 70.00, 130.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (243, 729, 6, '', 0.40, 1.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (244, 731, 6, '', 40.00, 220.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (245, 732, 6, '', 20.00, 125.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (246, 733, 6, '', 0.25, 0.75, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (247, 734, 6, '<', 99.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (248, 735, 6, '', 320.00, 1240.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (249, 736, 6, '', 50.00, 250.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (250, 737, 6, '<', 4.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (251, 738, 6, '<', 140.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (252, 740, 6, '', 73.00, 122.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (253, 741, 6, 'HOMBRES', 7.00, 44.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (254, 749, 6, '', -2.00, 2.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (255, 750, 6, 'HASTA', 38.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (256, 751, 6, '', 10.00, 50.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (257, 752, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (258, 774, 6, 'ADULTOS', 8.40, 10.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (259, 778, 6, '', 8.40, 10.20, '2', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (260, 780, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (261, 782, 6, '<', 0.20, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (262, 783, 6, '', 2.40, 4.80, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (263, 785, 6, '', 85.00, 95.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (264, 786, 6, '', 50.00, 126.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (265, 787, 6, '', 0.20, 2.58, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (266, 672, 6, '', 0.50, 1.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (267, 533, 4, '', 35.00, 55.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (268, 533, 3, '', 35.00, 55.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (269, 535, 6, '', 4.00, 10.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (270, 711, 4, '', 36.00, 42.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (271, 711, 3, '', 42.00, 54.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (272, 813, 6, '', 5.00, 25.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (273, 814, 6, '', 3.00, 13.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (274, 836, 3, '', 250.00, 950.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (275, 836, 14, '', 24.00, NULL, 'Mujeres premenopausia', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (276, 836, 15, '', 10.00, 181.00, 'Mujeres postmenopausia', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (277, 837, 6, '', NULL, 0.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (278, 878, 6, '0.2 - 1 SEMANAS:', 5.00, 50.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (279, 145, 6, '', 5.00, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (280, 913, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (281, 913, 7, '', 0.90, 1.00, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (282, 913, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (283, 914, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (284, 914, 7, '', 0.90, 1.01, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (285, 914, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (286, 916, 6, '>', 1.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (287, 917, 6, '>', 1.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (288, 918, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (289, 918, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (290, 918, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (291, 919, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (292, 919, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (293, 919, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (294, 922, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (295, 922, 7, '', 0.90, 1.10, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (296, 922, 8, '>', 1.10, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (297, 923, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (298, 923, 7, '', 0.90, 1.00, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (299, 923, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (300, 238, 8, '', 0.90, 1.00, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (301, 564, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (302, 564, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (303, 564, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (304, 563, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (305, 563, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (306, 563, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (307, 924, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (308, 924, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (309, 924, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (310, 925, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (311, 925, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (312, 925, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (313, 926, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (314, 926, 7, '', 0.90, 1.10, 'Sospechoso', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (315, 926, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (316, 927, 6, '<', 2.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (317, 929, 6, '<', 8.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (318, 929, 7, '>', 8.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (319, 930, 6, '<', 8.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (320, 930, 7, '>', 8.00, NULL, 'Positivo', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (321, 931, 6, '<', 8.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (322, 931, 7, '>', 8.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (323, 932, 6, '<', 8.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (324, 932, 7, '>', 8.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (325, 933, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (326, 933, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (327, 934, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (328, 934, 7, '', 0.91, 0.99, 'Borderline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (329, 935, 6, '', 80.00, 110.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (330, 936, 6, '', 27.00, 31.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (331, 937, 6, '', 32.00, 35.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (332, 1003, 6, '', 50.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (333, 1004, 6, '', 15.00, 45.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (334, 1005, 6, '', 120.00, 130.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (335, 1055, 6, '', 15.00, 45.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (336, 1056, 6, '', 50.00, 80.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (337, 1057, 6, '', 120.00, 130.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (338, 1171, 6, '<', 25.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (339, 1172, 11, '<', 12.50, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (340, 1189, 6, '', 0.80, 1.20, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (341, 1192, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (342, 1192, 7, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (343, 1193, 6, 'NEGATIVO <', 0.90, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (344, 1193, 7, 'POSITIVO >', 1.10, NULL, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (345, 1194, 6, 'NEGATIVO <', 0.90, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (346, 1194, 7, 'POSITIVO >', 1.10, NULL, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (347, 1195, 6, '<', 8.00, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (348, 1195, 7, '>', 12.00, NULL, 'Positivo', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (349, 1202, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (350, 1202, 7, '', 0.90, 1.10, 'Dudoso', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (351, 1202, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (352, 1203, 6, '<', 0.90, NULL, 'Negativo', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (353, 1203, 7, '', 0.90, 1.10, 'Dudoso', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (354, 1203, 8, '>', 1.10, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (355, 1205, 6, 'DEFICIENTE HASTA', 10.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (356, 1208, 6, '<', 12.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (357, 1215, 6, '>', 18.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (358, 1216, 6, '>', 18.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (359, 702, 6, '', 8.40, 10.20, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (360, 704, 6, '', 0.50, 1.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (361, 690, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (362, 688, 6, '', 2.40, 4.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (363, 697, 6, '', 3.50, 5.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (364, 682, 6, '<', 1.00, NULL, 'Insuficiencia prerrenal', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (365, 682, 7, '>', 1.00, NULL, 'Daño renal', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (366, 687, 6, '<', 15.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (367, 1220, 6, '', 70.00, 110.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (368, 1225, 6, '', 5.00, 30.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (369, 583, 6, '', 0.50, 1.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (370, 581, 6, '', 2.50, 4.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (371, 1299, 6, '', 7.90, 66.10, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (372, 1301, 6, '', 30.00, 170.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (373, 920, 6, '>', 18.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (374, 920, 7, '', 12.00, 18.00, 'SOSPECHOSO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (375, 921, 6, '>', 18.00, NULL, 'POSITIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (376, 921, 7, '', 12.00, 18.00, 'SOSPECHOSO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (377, 1306, 6, '', NULL, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (378, 1471, 6, '', 0.60, 1.85, 'MÈTODO ELISA', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (379, 1472, 6, '', 2.80, 7.30, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (380, 1475, 6, '', 8.50, 22.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (381, 1500, 6, '<', 0.04, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (382, 1500, 7, '>=', 0.04, NULL, 'POSITIVO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (383, 1501, 6, '', 0.25, 0.75, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (384, 1298, 6, 'HASTA', 200.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (385, 1511, 3, '', 1.46, 11.60, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (386, 1511, 14, '20-24 AÑOS', 1.66, 9.49, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (387, 1511, 15, '25-29 AÑOS', 1.18, 9.16, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (388, 1511, 16, '30-34 AÑOS', 0.67, 7.55, '', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (389, 1511, 17, '35-39 AÑOS', 0.78, 5.24, '', 5, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (390, 1511, 24, '40-44 AÑOS', 0.10, 2.96, '', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (391, 1511, 25, '45-50 AÑOS', 0.05, 2.06, '', 7, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (392, 194, 5, 'NIÑOS', NULL, 3.03, '', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (393, 267, 8, 'POSITIVO >', 1.10, NULL, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (394, 1518, 6, '', 10.00, 160.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (395, 214, 8, '', 12.00, 18.00, 'SOSPECHOSO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (396, 921, 8, '<', 12.00, NULL, 'NEGATIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (397, 920, 8, '<', 12.00, NULL, 'NEGATIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (398, 1532, 6, '', 3.30, 5.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (399, 1533, 6, '', 0.20, 0.40, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (400, 1534, 6, '', 0.60, 1.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (401, 1535, 6, '', 0.60, 1.20, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (402, 1536, 6, '', 0.70, 1.30, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (403, 1537, 6, '', 6.00, 8.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (404, 1286, 6, '', 250.00, 400.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (405, 1554, 6, '', 250.00, 450.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (406, 1555, 6, '', NULL, 10.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (407, 1557, 6, '', NULL, 0.04, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (408, 1558, 6, '', NULL, 0.04, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (409, 1559, 14, 'FASE FOLICULAR', 26.00, 103.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (410, 1559, 15, 'MITAD DE CICLO', 11.00, 97.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (411, 1559, 16, 'FASE LUTEA', 28.00, 112.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (412, 233, 5, 'NIÑOS', 6.00, 79.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (413, 775, 11, '', 3.00, 6.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (414, 775, 5, '', 3.00, 7.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (415, 1568, 6, '', NULL, 0.04, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (416, 1574, 3, 'Hombres', 100.00, 300.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (417, 1574, 5, 'Niños', 16.00, 75.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (418, 1574, 4, 'Mujeres', 80.00, 340.00, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (419, 1575, 6, '', 15.00, 45.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (420, 1538, 6, '', 6.00, 8.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (421, 585, 6, '<', 0.40, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (422, 286, 7, '0 - 2 AÑOS:', 0.80, 2.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (423, 286, 8, '3 - 5 AÑOS:', 0.33, 2.17, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (424, 286, 9, '5 - 7 AÑOS:', 0.33, 1.49, '', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (425, 286, 10, '7 - 10 AÑOS:', 0.32, 0.97, '', 5, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (426, 286, 13, '10 - 14 AÑOS:', 0.22, 0.86, '', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (427, 569, 6, 'NIÑOS', NULL, 3.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (428, 569, 7, 'ADULTOS', NULL, 10.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (429, 290, 6, '', 50.00, 100.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (430, 1576, 6, 'HASTA', 1.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (431, 1576, 7, '', 1.00, 15.00, 'MÍNIMO RIESGO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (432, 1576, 8, '', 15.00, 60.00, 'BAJO RIESGO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (433, 1576, 9, 'MAYOR A', 60.00, NULL, 'ALTO RIESGO', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (434, 239, 5, 'NIÑOS', 111.00, 551.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (435, 1578, 6, '', NULL, 60.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (436, 1580, 6, '', NULL, 20.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (437, 1581, 6, '', NULL, 90.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (438, 1582, 6, '<', 12.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (439, 1582, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (440, 1583, 6, '<', 12.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (441, 289, 7, '', 20.00, 40.00, 'POSITIVO BAJO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (442, 289, 8, '', 40.00, 70.00, 'POSITIVO MODERADO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (443, 289, 9, '>', 70.00, NULL, 'POSITIVO ALTO', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (444, 1586, 6, '<', 20.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (445, 1586, 7, '>', 20.00, NULL, 'POSITIVO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (446, 1583, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (447, 1589, 6, 'HASTA', 6.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (448, 1593, 6, '< de 75 años', NULL, 300.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (449, 1593, 7, '>= de 75 años', NULL, 450.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (450, 225, 6, '<', 10.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (451, 599, 14, 'NORMAL            <', 25.00, NULL, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (452, 599, 15, 'ELEVADO:', 25.00, 355.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (453, 599, 16, 'MUY ELEVADO      >', 355.00, NULL, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (454, 599, 18, 'NORMAL             <', 17.00, NULL, '', 4, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (455, 599, 19, 'ELEVADO:', 17.00, 250.00, '', 5, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (456, 599, 20, 'MUY ELEVADO      >', 250.00, NULL, '', 6, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (457, 1596, 6, '<', 110.00, NULL, 'MÉTODO TURBIDIMETRÍA', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (458, 1588, 3, '', 25.00, 60.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (459, 1588, 4, '', 34.00, 246.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (460, 239, 11, '', 75.00, 212.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (461, 774, 7, 'NIÑOS', 9.00, 11.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (462, 1192, 8, '', 0.90, 1.10, 'Bordeline', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (463, 1701, 6, '', 0.80, 2.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (464, 1285, 14, '20 - 39 AÑOS', 0.20, 6.10, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (465, 1285, 15, '40 - 59 AÑOS', 0.30, 4.40, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (466, 1285, 16, '>= 60 AÑOS', 0.50, 3.40, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (467, 1285, 18, '20 - 39 AÑOS', 9.20, 34.60, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (468, 1285, 19, '40 - 59 AÑOS', 6.10, 30.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (469, 1285, 20, '>= 60 AÑOS', 6.10, 27.90, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (470, 1706, 6, '', 0.50, 1.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (471, 1582, 8, '>=', 18.10, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (472, 1583, 8, '>=', 18.10, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (473, 1208, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (474, 1208, 8, '>', 18.00, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (475, 1207, 6, '<', 12.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (476, 1207, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (477, 1207, 8, '>', 18.00, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (478, 1377, 6, '', 4.50, 19.80, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (479, 1766, 3, '', 392.00, 1090.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (480, 1766, 4, '', 301.00, 1093.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (481, 221, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (482, 221, 8, '<', 12.00, NULL, 'NEGATIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (483, 222, 7, '', 12.10, 18.00, 'INDETERMINADO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (484, 222, 8, '<', 12.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (485, 1215, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (486, 1215, 8, '<', 12.00, NULL, 'NEGATIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (487, 1216, 7, '', 12.10, 18.00, 'INDETERMINADO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (488, 1216, 8, '<', 12.00, NULL, 'NEGATIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (489, 1784, 6, '', 4.20, 6.10, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (490, 1788, 6, '', 2.00, 4.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (491, 1790, 6, '', 1.10, 2.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (492, 1792, 6, '', NULL, 0.25, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (493, 1559, 3, 'HOMBRES', 13.00, 71.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (494, 561, 6, '', 73.00, 122.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (495, 462, 11, '', 500.00, 2000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (496, 933, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (497, 934, 8, '>', 1.00, NULL, 'Positivo', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (498, 257, 6, '', 12.20, 40.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (499, 165, 6, '', 1.20, 2.20, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (500, 1798, 6, '', 83.00, 97.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (501, 1799, 6, '', 27.00, 32.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (502, 1800, 6, '', 32.00, 35.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (503, 1801, 2, '', NULL, 1.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (504, 1801, 5, '< 1 AÑO', NULL, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (505, 1801, 26, '1 - 5 AÑOS', NULL, 60.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (506, 1801, 27, '6 - 9 AÑOS', NULL, 90.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (507, 1801, 28, '10 - 15 AÑOS', NULL, 200.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (508, 1801, 11, 'ADULTOS', NULL, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (509, 1802, 6, '', 1.10, 1.35, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (510, 771, 6, 'MENOR DE', 10.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (511, 771, 11, 'MAYOR DE', 10.10, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (512, 1814, 6, 'PRE-MENOPAUSIA', NULL, 150.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (513, 1814, 11, 'POST-MENOPAUSIA', NULL, 90.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (514, 1816, 6, '<', 2.00, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (515, 1817, 6, '<', 0.90, NULL, 'NEGATIVO', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (516, 1817, 7, '', 0.91, 1.00, 'SOSPECHOSO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (517, 1817, 8, '>', 1.10, NULL, 'POSITIVO', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (518, 1825, 6, '', NULL, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (519, 1826, 6, '', NULL, 600.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (520, 1827, 6, '', NULL, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (521, 1828, 6, '', NULL, 600.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (522, 1829, 6, 'NO DETECTABLE <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (523, 1821, 3, '', 10.00, 24.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (524, 1821, 4, '', 12.60, 24.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (525, 1819, 6, '<', 5.00, NULL, 'EXPUESTOS', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (526, 1823, 6, '', 15.00, 60.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (527, 1819, 7, '<', 2.00, NULL, 'NO EXPUESTOS', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (528, 93, 6, '', NULL, 25.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (529, 741, 7, 'MUJERES', 4.00, 31.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (530, 741, 8, 'NIÑOS', 13.00, 38.00, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (531, 1816, 7, '>', 2.10, NULL, 'POSITIVO', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (532, 717, 11, 'ADULTOS', 8.40, 10.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (533, 717, 5, 'NIÑOS', 9.00, 11.50, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (534, 1881, 6, '', 20.00, 320.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (535, 1884, 6, '', NULL, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (536, 1892, 6, '', 25.00, 90.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (537, 1905, 6, '', 60.00, 120.00, 'SEGUNDOS', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (538, 50, 6, '', 2.50, 4.80, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (539, 1909, 6, '<', 15.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (540, 1909, 7, '', 15.00, 25.00, 'INDETERMINADO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (541, 1909, 11, '>', 25.00, NULL, 'POSITIVO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (542, 158, 18, 'PRE-PUBERTAD', 0.10, 0.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (543, 158, 19, 'ADULTOS', 2.50, 10.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (544, 158, 14, 'PRE-PUBERTAD', 10.00, 0.20, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (545, 158, 15, 'FASE FOLICULAR', 0.10, 1.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (546, 1284, 18, 'PRE- PUBERTAD', 0.10, 0.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (547, 1284, 19, 'ADULTOS', 2.50, 10.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (548, 1284, 14, 'PRE-PUBERTAD', 0.10, 0.20, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (549, 1284, 15, 'FASE FOLICULAR', 0.10, 1.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (550, 276, 17, '', 13950.00, 62530.00, '(14 SEMANAS)', 11, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (551, 276, 24, '', 12039.00, 70971.00, '(15 SEMANAS)', 12, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (552, 276, 25, '', 9040.00, 56451.00, '(16 SEMANAS)', 13, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (553, 1765, 4, '', 301.00, 1093.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (554, 1765, 3, '', 392.00, 1090.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (555, 1915, 6, '0 - 1 MES', 266.00, 295.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (556, 1915, 7, '3 - 15 AÑOS', 275.00, 295.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (557, 1915, 8, '16 - 59 AÑOS', 290.00, 310.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (558, 1915, 9, '> 60 AÑOS', 280.00, 301.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (559, 718, 6, 'ADULTOS', 2.50, 5.50, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (560, 718, 7, 'NIÑOS', 4.00, 7.00, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (561, 1922, 6, '', 135.00, 155.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (562, 1923, 6, '', 3.40, 5.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (563, 534, 6, '', 150.00, 450.00, '', 1, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (564, 42, 3, '', NULL, 6.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (565, 42, 4, '', NULL, 15.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (566, 42, 5, '', NULL, 13.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (567, 1432, 6, 'ADULTOS', 27.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (568, 1910, 6, '', NULL, 4.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (569, 1485, 6, 'HASTA', 165.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (570, 1932, 6, '', NULL, 0.80, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (571, 1933, 6, '', 12.00, 16.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (572, 1221, 6, '', NULL, 140.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (573, 788, 6, '', 2.00, 30.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (574, 1482, 6, 'HASTA', 38.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (575, 1483, 6, 'HASTA', 40.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (576, 1937, 6, 'HASTA', 40.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (577, 1939, 6, '', 4.50, 6.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (578, 1941, 6, '', NULL, 0.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (579, 1942, 3, '', 11.00, 50.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (580, 1942, 4, '', 7.00, 32.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (581, 75, 6, '', 2.80, 3.40, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (582, 1943, 6, 'HASTA', 165.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (583, 537, 6, '', NULL, 6.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (584, 538, 6, '', 50.00, 70.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (585, 539, 6, '', 20.00, 40.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (586, 540, 6, '', NULL, 8.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (587, 155, 6, '', NULL, 8.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (588, 275, 6, '', NULL, 200.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (589, 1957, 6, '', 3.40, 5.30, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (590, 252, 6, '', 230.00, 460.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (591, 161, 6, '', NULL, 0.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (592, 1956, 6, '', 135.00, 155.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (593, 1961, 6, '', 70.00, 110.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (594, 1964, 6, 'Niños y Adultos', 5320.00, 12920.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (595, 192, 6, 'MAYOR', 25.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (596, 1219, 6, '', 70.00, 110.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (597, 1966, 6, '', 95.00, 115.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (598, 1229, 6, '', 4.50, 7.50, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (599, 1230, 6, '', 1018.00, 1030.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (600, 1973, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (601, 1973, 8, 'POSITIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (602, 1432, 7, 'NIÑOS Y ADOLESCENTES', 75.00, 390.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (603, 85, 3, '', 4.40, 11.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (604, 85, 4, '', 4.80, 11.60, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (605, 1974, 6, '', 7.35, 7.45, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (606, 1975, 6, '', 35.00, 45.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (607, 1976, 6, '', 80.00, 105.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (608, 1977, 6, '', 18.00, 27.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (609, 1978, 6, '', -2.00, 3.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (610, 1979, 6, '', 92.00, 100.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (611, 1983, 6, '', 18.00, 27.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (612, 1980, 6, '', 7.31, 7.41, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (613, 1981, 6, '', 41.00, 51.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (614, 1982, 6, '', 35.00, 40.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (615, 1984, 6, '', -2.00, 3.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (616, 1964, 7, 'Embarazo', 3650.00, 9120.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (617, 878, 7, '1 - 2 SEMANAS:', 50.00, 500.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (618, 878, 8, '2 - 3 SEMANAS:', 100.00, 5000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (619, 878, 9, '3 - 4 SEMANAS:', 500.00, 10000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (620, 878, 10, '4 - 5 SEMANAS:', 1000.00, 50000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (621, 878, 13, '5 - 6 SEMANAS:', 10000.00, 100000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (622, 878, 22, '6 - 8 SEMANAS:', 15000.00, 200000.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (623, 49, 7, 'ADULTO JOVEN', 8.70, 10.70, '', 2, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (624, 49, 8, 'ADULTO', 8.50, 10.50, '', 3, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (625, 1985, 6, 'RECIEN NACIDOS', 22.00, 220.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (626, 1985, 7, '6 MESES 15 AÑOS', 7.00, 140.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (627, 1985, 8, 'MASCULINO ADULTO', 16.00, 220.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (628, 1985, 9, 'FEMENINO ADULTO', 10.00, 124.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (629, 148, 7, 'POSITIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (630, 82, 7, 'ADULTOS', 200.00, 835.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (631, 82, 8, 'ADULTOS > 60 AÑOS', 110.00, 800.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (632, 1376, 6, 'ELEVADO >', 20.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (633, 1376, 7, 'RANGO NORMAL', 6.00, 20.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (634, 1376, 8, 'POSIBLE DIFERENCIA', 4.00, 5.90, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (635, 1376, 9, 'DEFICIENCIA <', 4.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (636, 1988, 6, 'NEONATOS', 100.00, 250.00, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (637, 1437, 6, 'HASTA', 20.00, NULL, 'FASE FOLICULAR', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (638, 1437, 7, '', 15.00, 30.00, 'CICLO MEDIO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (639, 1437, 8, 'HASTA', 20.00, NULL, 'FASE LUTEA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (640, 1437, 9, '', 40.00, 200.00, 'POST-MENOPAUSIA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (641, 1437, 10, 'HASTA', 9.00, NULL, 'PRE-PUBERTD', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (642, 1437, 13, 'HOMBRES HASTA', 20.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (643, 182, 6, 'HASTA', 40.00, NULL, 'FASE FOLICULAR', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (644, 182, 7, '', 40.00, 150.00, 'CICLO MEDIO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (645, 182, 8, 'HASTA', 30.00, NULL, 'FASE LUTEA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (646, 182, 9, '', 20.00, 200.00, 'POST-MENOPAUSIA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (647, 182, 10, 'HASTA', 9.00, NULL, 'PRE-PUBERTAD', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (648, 182, 13, 'HOMBRES HASTA', 25.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (649, 182, 22, 'PRE-PUBERTAD HASTA', 17.00, NULL, '', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (650, 180, 6, 'FEMENINO', 100.00, 400.00, 'FASE FOLICULAR', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (651, 180, 7, '', 30.00, 100.00, 'MEDIO CICLO', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (652, 180, 8, '', 50.00, 150.00, 'FASE LUTEA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (653, 180, 9, '<', 18.00, NULL, 'POST-MONOPAUSIA', 0, '2025-11-25 22:19:17', '2025-11-25 22:19:17');
INSERT INTO `lab_reference_ranges` VALUES (654, 180, 10, '>', 3500.00, NULL, 'EMBARAZADAS', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (655, 180, 13, 'HASTA', 30.00, NULL, 'PRE-PUBERTAD 1 - 10 AÑOS', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (656, 180, 22, 'MASCULINO HASTA', 56.00, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (657, 81, 6, 'HOMBRES', 3.45, 17.42, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (658, 81, 7, 'MUJERES', 4.60, 25.07, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (659, 1946, 6, '', 0.30, 4.20, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (660, 51, 26, 'NIÑOS', 1.50, 2.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (661, 1284, 16, 'POSTMENOPAUSIA', 0.80, 0.35, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (662, 1988, 7, 'NIÑOS', 50.00, 120.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (663, 1988, 8, 'HOMBRES', 65.00, 175.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (664, 1988, 9, 'MUJERES', 50.00, 170.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (665, 1829, 7, 'DETECTABLE >', 1.10, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (666, 263, 7, 'DETECTABLE >', 1.10, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (667, 1205, 7, 'INSUFICIENTE', 10.00, 30.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (668, 1205, 8, 'SUFICIENTE', 30.00, 100.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (669, 258, 6, 'HOMBRES', 0.25, 3.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (670, 258, 7, 'MUJERES', 0.25, 3.00, 'PRE-MENOPAUSIACAS', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (671, 258, 8, 'MUJERES', 0.12, 1.50, 'POST-MENOPAUSIACAS', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (672, 158, 16, 'FACE LUTEA', 0.20, 0.80, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (673, 158, 17, 'POST-MENOPAUSIA', 0.08, 0.35, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (674, 1480, 18, '20 - 39 AÑOS', 9.20, 34.60, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (675, 1480, 19, '40 - 59 AÑOS', 6.10, 30.30, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (676, 1480, 20, '> 60 AÑOS', 6.10, 27.90, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (677, 1480, 14, '20 - 39 AÑOS', 0.20, 6.10, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (678, 1480, 15, '40 - 59 AÑOS', 0.30, 4.40, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (679, 1480, 16, '> 60 AÑOS', 0.50, 3.40, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (680, 236, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (681, 236, 7, 'INTERMEDIO', 0.90, 1.00, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (682, 236, 8, 'POSITIVO >', 1.00, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (683, 190, 6, 'NEGATIVO <', 0.90, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (684, 190, 7, 'POSITIVO >', 1.10, NULL, '', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (685, 1474, 6, 'MUJERES', 4.80, 11.60, 'METODO ELISA', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (686, 1992, 6, '<', 100.00, NULL, 'NEGATIVO', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');
INSERT INTO `lab_reference_ranges` VALUES (687, 1992, 7, '>', 100.00, NULL, 'POSITIVO', 0, '2025-11-25 22:19:18', '2025-11-25 22:19:18');

-- ----------------------------
-- Table structure for lab_results
-- ----------------------------
DROP TABLE IF EXISTS `lab_results`;
CREATE TABLE `lab_results`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `lab_order_detail_id` bigint UNSIGNED NOT NULL,
  `lab_exam_item_id` bigint UNSIGNED NOT NULL,
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lab_results_lab_order_detail_id_foreign`(`lab_order_detail_id`) USING BTREE,
  INDEX `lab_results_lab_exam_item_id_foreign`(`lab_exam_item_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lab_results
-- ----------------------------
INSERT INTO `lab_results` VALUES (1, 9, 83, '3.4', NULL, '2025-11-27 16:47:40', '2025-11-27 16:47:40');
INSERT INTO `lab_results` VALUES (2, 10, 1471, '1.1', NULL, '2025-11-27 16:47:40', '2025-11-27 16:47:40');
INSERT INTO `lab_results` VALUES (3, 10, 1472, '4.5', NULL, '2025-11-27 16:47:40', '2025-11-27 16:47:40');
INSERT INTO `lab_results` VALUES (4, 11, 148, '1.4', NULL, '2025-11-27 17:01:47', '2025-11-27 17:01:47');
INSERT INTO `lab_results` VALUES (5, 12, 281, '1.35', NULL, '2025-11-27 17:01:47', '2025-11-27 17:01:47');

-- ----------------------------
-- Table structure for materiales
-- ----------------------------
DROP TABLE IF EXISTS `materiales`;
CREATE TABLE `materiales`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `clinica_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `unidad_medida_default` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `categoria_default` enum('ENFERMERIA','QUIROFANO','UCI','OFICINA') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stock_minimo` int NULL DEFAULT 0,
  `stock_actual` int NOT NULL DEFAULT 0,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of materiales
-- ----------------------------
INSERT INTO `materiales` VALUES (1, 1, '163MEDAI', 'MONONYLON 163 NYLON 3-0', 'MONONYLON 163 NYLON 3-0 CAJA X 12 UNDS MEDA', 'CAJA', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (2, 1, '813CROM', 'CATGUT CRÓMICO 1 (813)', 'CATGUT CROMICO 1 (813) CAJA X 12 BIALLY', 'CAJA', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (3, 1, 'GUD0002', 'GUANTES DE EXAMEN TALLA M', 'GUANTES DE EXAMEN TALLAM CAJA X 100 UDS DI', 'CAJA', 'ENFERMERIA', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (4, 1, 'GUD0003', 'GUANTES DE EXAMEN LÁTEX TALLA S', 'GUANTES DE EXAMEN LATEX TALLA S DIPHOCARE', 'CAJA', 'ENFERMERIA', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (5, 1, 'CMCM001', 'CUBRE BOTA PAQX100 UNDS', 'CUBRE BOTA PAQX100 UNDS MC MEDICAL', 'PAQUETE', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (6, 1, 'HOJ0036', 'HOJILLA DE BISTURI NRO 10', 'HOJILLA DE BISTURI NRO 10 CAJA X 100 UND DIPHO', 'CAJA', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (7, 1, 'TU656', 'TUBO ENDOTRAQUEAL C/B 6.5MM', 'TUBO ENDOTRAL C/B 6.5MM CAJA X IOUNDS GROSS', 'CAJA', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (8, 1, 'AG000460', 'AGUA OXIGENADA GALÓN GUARDIAN', 'AGUA OXIGENADA GALON GUARDIAN (E)', 'GALON', 'ENFERMERIA', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (9, 1, 'AL-001', 'ALCOHOL ANTISÉPTICO AL 70% GALÓN', 'ALCOHOL ANTICEPTICO AL 70% GALON VITALITY', 'GALON', 'ENFERMERIA', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (10, 1, 'DRE007000', 'DRENAJE PLEUREVAC ADUL/PED', 'DRENAJE PLEUREVAC ADUL/PED TELEFLEX MEDI', 'UNIDAD', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (11, 1, 'OBT00241', 'OBTURADOR AMARILLO', 'OBTURADOR AMARILLO CAJA X 100 UNDS MC MED', 'CAJA', 'QUIROFANO', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);
INSERT INTO `materiales` VALUES (12, 1, 'UR444', 'UROLAB RECOLECTOR DE ORINA POT', 'UROLAB RECOLECTOR DE ORINA POT X 100 UND H', 'UNIDAD', 'ENFERMERIA', 0, 0, 1, '2025-11-26 21:09:21', '2025-11-26 21:09:21', NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2025_11_04_000000_create_clinicas_table', 1);
INSERT INTO `migrations` VALUES (5, '2025_11_04_000100_add_clinica_id_to_users_table', 1);
INSERT INTO `migrations` VALUES (6, '2025_11_04_000200_create_suscripciones_table', 1);
INSERT INTO `migrations` VALUES (7, '2025_11_04_000300_create_citas_table', 1);
INSERT INTO `migrations` VALUES (8, '2025_11_04_000400_create_resultados_laboratorio_table', 1);
INSERT INTO `migrations` VALUES (9, '2025_11_04_001000_add_cedula_to_usuarios_table', 1);
INSERT INTO `migrations` VALUES (10, '2025_11_04_134759_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (11, '2025_11_05_000500_create_especialidades_table', 2);
INSERT INTO `migrations` VALUES (12, '2025_11_05_000600_add_especialidad_id_to_usuarios_table', 2);
INSERT INTO `migrations` VALUES (13, '2025_11_05_002000_create_disponibilidades_table', 2);
INSERT INTO `migrations` VALUES (14, '2025_11_05_010000_create_pagos_reportados_table', 2);
INSERT INTO `migrations` VALUES (15, '2025_11_08_120000_create_settings_table', 3);
INSERT INTO `migrations` VALUES (16, '2025_11_08_130000_create_exchange_rates_table', 4);
INSERT INTO `migrations` VALUES (17, '2025_11_08_120000_add_numero_to_suscripciones_table', 5);
INSERT INTO `migrations` VALUES (18, '2025_11_08_120000_add_gestion_fields_to_citas_table', 6);
INSERT INTO `migrations` VALUES (19, '2025_11_08_120100_create_cita_adjuntos_table', 6);
INSERT INTO `migrations` VALUES (20, '2025_11_08_120200_create_cita_medicamentos_table', 6);
INSERT INTO `migrations` VALUES (21, '2025_11_09_000000_create_atenciones_table', 7);
INSERT INTO `migrations` VALUES (22, '2025_11_09_000100_create_atencion_medicamentos_table', 7);
INSERT INTO `migrations` VALUES (23, '2025_11_09_000200_create_atencion_adjuntos_table', 7);
INSERT INTO `migrations` VALUES (24, '2025_11_13_000000_create_especialidad_usuario_table', 8);
INSERT INTO `migrations` VALUES (25, '2025_11_25_011000_fix_missing_clinicas_table', 9);
INSERT INTO `migrations` VALUES (26, '2025_11_25_011953_create_materiales_table', 10);
INSERT INTO `migrations` VALUES (27, '2025_11_25_012000_create_solicitudes_inventario_table', 11);
INSERT INTO `migrations` VALUES (28, '2025_11_25_012011_create_items_solicitud_inventario_table', 11);
INSERT INTO `migrations` VALUES (29, '2025_11_25_125112_create_laboratory_tables', 12);
INSERT INTO `migrations` VALUES (30, '2025_11_25_130823_create_lab_reference_tables', 12);
INSERT INTO `migrations` VALUES (32, '2025_11_25_180000_create_complete_lab_orders_system', 13);
INSERT INTO `migrations` VALUES (33, '2025_11_25_200000_add_daily_exam_count_to_lab_orders_table', 14);
INSERT INTO `migrations` VALUES (34, '2025_11_25_152500_add_daily_exam_count_to_lab_orders_table', 15);
INSERT INTO `migrations` VALUES (35, '2025_11_25_192051_add_daily_exam_count_to_lab_orders_table', 15);
INSERT INTO `migrations` VALUES (36, '2025_11_25_120000_update_atenciones_add_empresa_titular_operador_siniestro', 16);
INSERT INTO `migrations` VALUES (37, '2025_11_25_215435_drop_resultados_laboratorio_table', 16);
INSERT INTO `migrations` VALUES (38, '2025_11_26_021503_add_sexo_to_usuarios_table', 16);
INSERT INTO `migrations` VALUES (39, '2025_11_26_120000_add_fecha_nacimiento_to_usuarios_table', 16);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 1);
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (2, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 4);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 10);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 12);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 13);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 14);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 17);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 18);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 20);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 22);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 26);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 27);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 28);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 29);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 32);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 33);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 34);
INSERT INTO `model_has_roles` VALUES (4, 'App\\Models\\User', 35);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 16);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (5, 'App\\Models\\User', 23);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 30);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 31);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 5);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 7);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 8);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 9);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 11);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 15);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 19);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 24);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 25);
INSERT INTO `model_has_roles` VALUES (7, 'App\\Models\\User', 36);
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 16);
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (8, 'App\\Models\\User', 23);
INSERT INTO `model_has_roles` VALUES (9, 'App\\Models\\User', 6);
INSERT INTO `model_has_roles` VALUES (9, 'App\\Models\\User', 21);
INSERT INTO `model_has_roles` VALUES (9, 'App\\Models\\User', 32);

-- ----------------------------
-- Table structure for movimiento_inventarios
-- ----------------------------
DROP TABLE IF EXISTS `movimiento_inventarios`;
CREATE TABLE `movimiento_inventarios`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `material_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int NOT NULL,
  `stock_anterior` int NOT NULL DEFAULT 0,
  `stock_nuevo` int NOT NULL DEFAULT 0,
  `motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `referencia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movimiento_inventarios_material_id_foreign`(`material_id`) USING BTREE,
  INDEX `movimiento_inventarios_user_id_foreign`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movimiento_inventarios
-- ----------------------------

-- ----------------------------
-- Table structure for pagos_reportados
-- ----------------------------
DROP TABLE IF EXISTS `pagos_reportados`;
CREATE TABLE `pagos_reportados`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `cedula_pagador` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_pagador` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_pago` date NOT NULL,
  `referencia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(10, 2) NOT NULL,
  `estado` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `reviewed_by` bigint UNSIGNED NULL DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pago_unico_ref_monto_fecha`(`referencia`, `monto`, `fecha_pago`) USING BTREE,
  INDEX `pagos_reportados_usuario_id_foreign`(`usuario_id`) USING BTREE,
  INDEX `pagos_reportados_reviewed_by_foreign`(`reviewed_by`) USING BTREE,
  INDEX `pagos_reportados_estado_index`(`estado`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pagos_reportados
-- ----------------------------
INSERT INTO `pagos_reportados` VALUES (1, 30, 'V-32649049', '0424-1938055', '2025-11-26', '123456', 2435.73, 'pendiente', NULL, NULL, NULL, '2025-11-26 22:41:57', '2025-11-26 22:41:57');
INSERT INTO `pagos_reportados` VALUES (2, 31, 'V-21658027', '0424-3562758', '2025-11-27', '99998888', 2446.50, 'aprobado', NULL, 21, '2025-11-27 16:58:19', '2025-11-27 16:57:37', '2025-11-27 16:58:19');

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
INSERT INTO `password_reset_tokens` VALUES ('girlabielys@gmail.com', '$2y$12$dWNXm2R4CoOnk1BJtulG.u3aP2GZY1hd7LnA3FDN/zUpiPUTN8Pb2', '2025-11-27 20:25:03');
INSERT INTO `password_reset_tokens` VALUES ('jponciang@gmail.com', '$2y$12$aRl1z8IgnPrRP7CT/vU16OK0Py0Q4N5sztLPEo5jAOvfbgFEAfi6a', '2025-11-27 18:18:14');
INSERT INTO `password_reset_tokens` VALUES ('mariadelccelis@gmail.com', '$2y$12$al8djgnbDONdq9qE2/4ufewZ5P6YzB1IJC/YURTxoVdw/MEMw8v5.', '2025-11-22 18:06:57');
INSERT INTO `password_reset_tokens` VALUES ('josealejandrocortezmedina@gmail.com', '$2y$12$JijJM/WOtN6dhDpbcUOCK.h11pve1btjODIjbJW8aHOO0./3l8hRG', '2025-11-27 20:23:54');
INSERT INTO `password_reset_tokens` VALUES ('angelvalera80@gmail.com', '$2y$12$wqANZEa/T6ff7VYI4EwKneERAJNrCGaeAmGLBC0iSvog6DHzkbtd.', '2025-11-27 20:24:08');
INSERT INTO `password_reset_tokens` VALUES ('adonitareyes1691@gmail.com', '$2y$12$ptLY/tHf86N7R3UXxCnSYebWk79S75qtNL.K5t459vwL4xGuYdive', '2025-11-27 20:24:22');
INSERT INTO `password_reset_tokens` VALUES ('benavidessantisebas2020@gmail.com', '$2y$12$u.7J.WacUt90ctca/o4d2ezlPP6b61qSKYMxofLBbtCrozAfJu7/.', '2025-11-27 20:22:40');
INSERT INTO `password_reset_tokens` VALUES ('hectorcorrosolorzano@gmail.com', '$2y$12$fV.TdfcqG2XFpTYTf0MBSe2aJTLWsbv9rVOtLpQGGiRzbVP5/KbpG', '2025-11-27 17:49:00');
INSERT INTO `password_reset_tokens` VALUES ('telefonodevicente@gmail.com', '$2y$12$aDXRA2c/Z.5EBKWLgqYelOfU4rzx5GFQ0dCIXzmHJZ0Ii93.5TDf6', '2025-11-27 18:10:11');
INSERT INTO `password_reset_tokens` VALUES ('nazarethahernandeza@gmail.com', '$2y$12$JnYIIboqhVimzCQopEkCW.GwLW5zfUWDq3dMGiNvy/jLztzJ2Gh1a', '2025-11-27 20:22:59');
INSERT INTO `password_reset_tokens` VALUES ('alemedic27@gmail.com', '$2y$12$9IC0qjaceQbgvVsYxyfiNuTN.3m90PXOQblMMc2iE0ufjI6lNEdji', '2025-11-27 20:23:15');
INSERT INTO `password_reset_tokens` VALUES ('yessis_1121@hotmail.com', '$2y$12$FPmGyZ0l.RSWL0Y9Lkz8p.4rgdjJ/sgt4BA7aFg7gYf6zx20re2HC', '2025-11-27 20:23:32');
INSERT INTO `password_reset_tokens` VALUES ('doctora.oviedo@gmail.com', '$2y$12$GPMJp3iw1YUgwT4LRimS5e9G6ZD1uljzX7vlNjFlsbegaEXaFrNTy', '2025-11-27 20:24:34');
INSERT INTO `password_reset_tokens` VALUES ('fernandesannys@gmail.com', '$2y$12$OE.WyxImkD5cFM2Jj6vNGeQ7bnsJegU7JQgT3KExaUHP6C42M6nJC', '2025-11-27 20:24:46');
INSERT INTO `password_reset_tokens` VALUES ('francibalza1986@gmail.com', '$2y$12$KsZTuCvP2SEda1WhxT65J.7SGrhJFe5odtuKSMc7v22b4QgpkjGWi', '2025-11-27 20:25:23');
INSERT INTO `password_reset_tokens` VALUES ('arangurenjohandri@gmail.com', '$2y$12$whM1OFkzB0Cy6DqVpWpbCOYjaaw2oek/lluA9TL8gLLrppWT49KW6', '2025-11-27 20:25:43');
INSERT INTO `password_reset_tokens` VALUES ('luispaulmar@gmail.com', '$2y$12$87../BSF4bkLz/5787Ed7uUGn3KuThT69RT340aG9fEV/pNrzg4QO', '2025-11-27 21:37:56');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_guard_name_unique`(`name`, `guard_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name`, `guard_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'super-admin', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (2, 'admin_clinica', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (3, 'recepcionista', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (4, 'especialista', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (5, 'laboratorio', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (6, 'paciente', 'web', '2025-11-05 10:06:46', '2025-11-05 10:06:46');
INSERT INTO `roles` VALUES (7, 'almacen', 'web', '2025-11-25 17:04:14', '2025-11-25 17:04:14');
INSERT INTO `roles` VALUES (8, 'laboratorio-resul', 'web', '2025-11-27 11:31:00', '2025-11-27 11:31:00');
INSERT INTO `roles` VALUES (9, 'almacen-jefe', 'web', '2025-11-27 11:31:01', '2025-11-27 11:31:01');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id`) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('6igAGAvP2ojzSIGdVg5a64kl9Ev55Jc7U2lmfrwp', NULL, '72.14.199.139', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGl0bzd6MldUZFZ4aHg1Vzl0Zk5xRFhTRlZJVDk0enhaNlUwakV6ayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vY2xpbmljYXNhbHVkc29ucmlzYS5jb20udmUvcmVnaXN0ZXIiO3M6NToicm91dGUiO3M6ODoicmVnaXN0ZXIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1764281737);
INSERT INTO `sessions` VALUES ('3aUnJCNFYJsmOWCk2f7jnoPj9kofHbtWE0QTRIy7', NULL, '82.86.113.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibHprczlsdWRqOW5nbHdYeDA2cjFNTlp2RnlOU1VscTVRMjBTUndocSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTc6Imh0dHBzOi8vY2xpbmljYXNhbHVkc29ucmlzYS5jb20udmUvbG9naW4/cGVyZmlsPWVtcGxlYWRvcyI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fX0=', 1764284988);
INSERT INTO `sessions` VALUES ('YxWvRjRwsuB4qF1oYhFzrOVywPE5GAi9i64FkQdB', NULL, '38.41.23.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlFZZnJpbXN2VXc3UHlObXB3clRpbms0eXpxMTBaWW9XUm5JZHhkQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vY2xpbmljYXNhbHVkc29ucmlzYS5jb20udmUiO3M6NToicm91dGUiO047fX0=', 1764279705);
INSERT INTO `sessions` VALUES ('QgzEqxQOUj4Lceetw7pSu6bFpMwTeI0Z1B7uOxuA', NULL, '38.41.23.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU29JWmFwM1BHWkRMbDhnV2w4QlBnOHFGaE9RMHgwYTdHaWJUYnJ3QiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vY2xpbmljYXNhbHVkc29ucmlzYS5jb20udmUvcHVibGljIjtzOjU6InJvdXRlIjtOO319', 1764279763);
INSERT INTO `sessions` VALUES ('Y9cY7eyI9qankVWFufzCuUS6r0hlstUWH0g4NCfc', NULL, '72.14.199.137', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXVCMFh6QnRmWGtXNjAwUWVHZ1FRSExmMTJ1S0pEbTNhdjFnQzZVSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vY2xpbmljYXNhbHVkc29ucmlzYS5jb20udmUiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1764281497);

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `settings_key_unique`(`key`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'pago_movil_banco', 'BANESCO', '2025-11-26 20:05:14', '2025-11-26 20:05:14');
INSERT INTO `settings` VALUES (2, 'pago_movil_identificacion', 'J-40151643-2', '2025-11-26 20:05:14', '2025-11-26 20:05:14');
INSERT INTO `settings` VALUES (3, 'pago_movil_telefono', '0412-4543730', '2025-11-26 20:05:14', '2025-11-26 20:05:14');
INSERT INTO `settings` VALUES (4, 'pago_movil_nombre', 'Somos Salud', '2025-11-26 20:05:14', '2025-11-26 20:05:14');

-- ----------------------------
-- Table structure for solicitudes_inventario
-- ----------------------------
DROP TABLE IF EXISTS `solicitudes_inventario`;
CREATE TABLE `solicitudes_inventario`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero_solicitud` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `solicitante_id` bigint UNSIGNED NOT NULL,
  `clinica_id` bigint UNSIGNED NOT NULL,
  `categoria` enum('ENFERMERIA','QUIROFANO','UCI','OFICINA') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('pendiente','aprobada','rechazada','despachada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `observaciones_solicitante` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `observaciones_aprobador` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `aprobado_por` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha_aprobacion` timestamp NULL DEFAULT NULL,
  `despachado_por` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha_despacho` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitudes_inventario
-- ----------------------------
INSERT INTO `solicitudes_inventario` VALUES (1, 'SOL-2025-0001', 21, 1, 'ENFERMERIA', 'aprobada', 'ejemplo numero uno de solicitud de materiales', 'aumente la cantidad de agua. solicitaron una y agregue dos mas para un total de tres', 21, '2025-11-27 16:02:25', NULL, NULL, '2025-11-27 16:01:01', '2025-11-27 16:02:25');
INSERT INTO `solicitudes_inventario` VALUES (2, 'SOL-2025-0002', 21, 1, 'ENFERMERIA', 'pendiente', 'repocision de material', NULL, NULL, NULL, NULL, NULL, '2025-11-27 16:42:57', '2025-11-27 16:42:57');

-- ----------------------------
-- Table structure for suscripciones
-- ----------------------------
DROP TABLE IF EXISTS `suscripciones`;
CREATE TABLE `suscripciones`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `numero` bigint UNSIGNED NULL DEFAULT NULL,
  `plan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(8, 2) NOT NULL,
  `periodo_inicio` date NOT NULL,
  `periodo_vencimiento` date NOT NULL,
  `estado` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `metodo_pago` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manual',
  `transaccion_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `suscripciones_numero_unique`(`numero`) USING BTREE,
  INDEX `suscripciones_usuario_id_foreign`(`usuario_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of suscripciones
-- ----------------------------
INSERT INTO `suscripciones` VALUES (1, 31, 1, 'anual', 10.00, '2025-11-27', '2026-11-27', 'activo', 'pago_movil', 'PM-99998888-20251127', '2025-11-27 16:58:19', '2025-11-27 16:58:19');

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `representante_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `fecha_nacimiento` date NULL DEFAULT NULL,
  `sexo` enum('M','F') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `clinica_id` bigint UNSIGNED NULL DEFAULT 1,
  `especialidad_id` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `usuarios_cedula_unique`(`cedula`) USING BTREE,
  INDEX `usuarios_clinica_id_foreign`(`clinica_id`) USING BTREE,
  INDEX `usuarios_especialidad_id_foreign`(`especialidad_id`) USING BTREE,
  INDEX `fk_usuarios_representante_id`(`representante_id`) USING BTREE,
  INDEX `usuarios_email_representante_idx`(`email`, `representante_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (1, NULL, 'Super Administrador', 'V-16912337', NULL, 'M', 'jponciang1@gmail.com', '2025-11-26 16:39:54', '$2y$12$Tn0rL8pSAYTcwjhxcKsQvezB.dHylhRccqmMI7jqamCu5Oo/uE2dO', NULL, '2025-11-25 16:39:54', '2025-11-25 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (2, NULL, 'Adonis Josefina Reyes Delgado', 'V-16913118', '1991-04-14', 'F', 'adonitareyes1691@gmail.com', NULL, '$2y$12$lVPqbngzI04ftXLnPJj7rOiZOwjKAjW/Op0ogcUh8fIAOYYBbl8na', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (3, NULL, 'Adrian Emanuel Alvarado', 'V-21658027', '2000-11-02', 'M', 'adriema337@gmail.com', NULL, '$2y$12$Zhyw/hLqRl6wnxeNJoQfL.Qogr32lq98JjiDTCx5yVHszau0cQmPO', 'kOJszdMXeY0Az53fOMtmzrX6HC8D87pu1ClGfaQ74Ee9xRCd9amb3uzgz7ws', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (4, NULL, 'Anais Josefina Oviedo Gutierrez', 'V-14926235', '1981-11-07', 'F', 'doctora.oviedo@gmail.com', NULL, '$2y$12$TLcHUyh0GZfDBQuiFd19s.AWCQmSAfp9064X4hV8o.rC6r89na9A.', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (5, NULL, 'Annys Manuela Fernández Meléndez', 'V-19943785', '2000-01-01', 'F', 'fernandesannys@gmail.com', NULL, '$2y$12$kkFAGRiQIAywpi7F7JdQ4OXrL6JhI1MKyHbmX0nzrdqN3K4PNSE7y', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (6, NULL, 'Carmen Endey Gutierrez', 'V-10584633', '1969-04-10', 'F', 'chamonixr9@gmail.com', NULL, '$2y$12$TC4m88UfWz4J8dszKCfdHuDLSZ0VTsPw686ErtbVi14N2fbctNfJK', 'ktZCNN2J5xdERTKqPrYIgMcrZc9bULibljMbo1XCvQLb97Vi1rACg3jOXM56', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (7, NULL, 'Evelyn Patricia Rivas Ramdial', 'V-18583984', '1986-10-29', 'F', 'benavidessantisebas2020@gmail.com', NULL, '$2y$12$dDKz.C/i3yufsYwFg8AdCeQ1oveJaRx3AhltBEP.Z3Vx75uNVJAEG', NULL, '2025-11-26 16:39:54', '2025-11-27 20:22:26', 1, NULL);
INSERT INTO `usuarios` VALUES (8, NULL, 'Fanny Mariela Aguirre Ramos', 'V-15481987', '1983-05-12', 'F', 'girlabielys@gmail.com', NULL, '$2y$12$EcMykssiqFRviPSEns7IseIIviA/oOriFASXOTRZlbfV2JMgUCYxu', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (9, NULL, 'Franci Zulay Balza Montoya', 'V-18220639', '1986-12-18', 'F', 'francibalza1986@gmail.com', NULL, '$2y$12$ba3BwmOslzkKEiqMtOBO5u149NHwp4gff/ERw2V9pYzyKxQJoCiiK', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (10, NULL, 'Johandri Marilu Aranguren Daniel', 'V-19476686', '1988-11-20', 'F', 'arangurenjohandri@gmail.com', NULL, '$2y$12$xlR492jgGYpGsblUUqQy1eC5Cj9lUn.piXMLsqdB02Q2CYOYi0u4S', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (11, NULL, 'Karines de Jesus Carvajal Astudillo', 'V-20884344', '1993-01-12', 'F', 'karinescarvajal@gmail.com', NULL, '$2y$12$mJv1F5NkXE7yO1AZlFO7q.vTT8/vBBGniWXNpKMBBAXt2oiWqWZli', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (12, NULL, 'Laura Josefina Muñoz Barrios', 'V-8626667', '1967-05-05', 'F', 'lauramuba@hotmail.com', NULL, '$2y$12$FSA4dVHarnNUmmInRuUhs.itq0N55E7YLrBZgXyVdUx7Vn1Q5X4HK', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (13, NULL, 'María del Carmen Celis Alfonzo', 'V-17602635', '1980-05-15', 'F', 'mariadelccelis@gmail.com', NULL, '$2y$12$BzXWNP24l6TPz5AjNQ0d0Oq4AWagO74jg2/qsuMHtB6/LQIfK/2F.', 'NWPYc8JvtgEjtgKH2Rae2BKEg4krOVlgZC946bSB1caLpGnG1DRZ5OMkSYFF', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (14, NULL, 'Maria Gabriela Parababi Funes', 'V-24662770', '1995-03-30', 'F', 'gabyparababy1995@gmail.com', NULL, '$2y$12$dCpfRkz/b9urkvB4uG/LrOlAYYq8WSsjSkejNcJVDiy5Ok./YCgkG', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (15, NULL, 'Mariana Alejandra Pérez', 'V-27331304', '1999-11-29', 'F', 'maricelespd@gmail.com', NULL, '$2y$12$2Pw9XkWdIb.69hHijJQL7e3ME7ri7e9wcBMH2VfTJFC5b5LZzYwlW', 'sKVJ9j71jEVXKh27se2wa0aEVYbBi82cAvNpvPx4ErdnIxO0Gp0wGlp0zj5l', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (16, NULL, 'Nerys Yoselin Torres Morales', 'V-16640787', '2000-07-06', 'F', 'nerysyoselin340@gmail.com', NULL, '$2y$12$3lzQaZhtAFawLcnhGE4iN.Ulc8sUgqi0IO5bQX1U3Uc.6b5toMTbe', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (17, NULL, 'Reina de Jesus Vega Mercado', 'V-19160669', '1989-01-06', 'F', 'reynavegas1989@gmail.com', NULL, '$2y$12$MeU4gA2J.95wRA6tKW3tNOif/OJUrX5Vzlc3gecFuDp57pUmKEt.2', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (18, NULL, 'Ruth Eniddari Mujica Padilla', 'V-18908202', '2000-05-30', 'F', 'ruthmujica391@gmail.com', NULL, '$2y$12$K4dHQLdZVUwrUOzrKJvDzOIJe1F.OXIFfV9RxOCaGt02En03Qia9a', '5p77eZTez38MqNcssOsb7dE1kzXF1X6LOFVNcSeNJ0ro2vZ3OTyzJ408874f', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (19, NULL, 'Rutmary Herminia Morales Ruiz', 'V-12476502', '2000-07-07', 'F', 'rutmarymorales60@gmail.com', NULL, '$2y$12$d6W4FWUiNJp3V8QWaedFH.Z4W.l/N6U8XUhLn0Fm8PVAuhtfieTui', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (20, NULL, 'Silvia Patricia Bernudez Corona', 'V-18405632', '1988-03-24', 'F', 'silviabermudez2488@gmail.com', NULL, '$2y$12$CL3oWkgc.8yCsQeJezuMKeJ3hzbTHrCbp9pxoIZaRR7sKJxpsrGMC', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (21, NULL, 'Vicente Emilio Alfonzo Marcano', 'V-6922095', '1966-10-12', 'M', 'telefonodevicente@gmail.com', NULL, '$2y$12$zoXlvuZSPL4cnuEFtb084eoXOe6A1d1ykI5NyQG8kksf05iFxQCS.', 'wEg7vMlPs0G19siv4e2HI0Q7zvp2SSqvYlXPgGBIEzT6gO8ic0gzBxZklMwA', '2025-11-26 16:39:54', '2025-11-27 18:18:37', 1, NULL);
INSERT INTO `usuarios` VALUES (22, NULL, 'Willian Isaac Guzman Madera', 'V-26752296', '2000-01-01', 'M', 'wili@gmail.com', NULL, '$2y$12$07k1CoKTIgfxnYEWESYZU.2WL2D981x19Shu7XycdmTAUsl0y2Fn2', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (23, NULL, 'Winder Jesús González Benavides', 'V-26452252', '2001-10-11', 'M', 'winderjgonzalezb07@gmail.com', NULL, '$2y$12$ViuYSuuff20B7VfrfEOIy.HAekep3xdHb8CyaBaOVidiMmg081KCC', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (24, NULL, 'Yeniffer Andreina Rojas Perez', 'V-29791345', '2000-07-01', 'F', 'yenifferrojas09@gmail.com', NULL, '$2y$12$i8nK2bzFzCjvSLPbtd4iLu1c0GwjfBzakkFPFjZ5U/9h6WpOYhV0a', 'iBYdOJJ5TNGqZGgaG34EJkJi4dO1NGzUuQr0EiJxcSjUoJwVw3SLRwbD16rD', '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (25, NULL, 'YORAIMA  NAZARETH CARRASQUEL', 'V-26752895', '1999-04-29', 'F', 'ynazacr26@gmail.com', NULL, '$2y$12$pIzs09Zpb03HhfKL2t25CO0RM0ha2S/PUttW1odHZijczArnVG2ce', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (26, NULL, 'Yoseidy Coromoto Aquino Peña', 'V-18406248', '2000-08-07', 'F', 'licyoseidyaquino@gmail.com', NULL, '$2y$12$VhMM09j9ES.pLVBhSePIYuBNNv3UHUBLStAe1p.10uM/boRxOaBVq', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (27, NULL, 'Yuris Josefina Bastidas Verenzuela', 'V-20906301', '1992-09-02', 'F', 'bastidasyury3@gmail.com', NULL, '$2y$12$ES5KYme.TdtFUTSXwkWiJOYmv9oBC3/XENN6P./XP0zcca07ajJXi', NULL, '2025-11-26 16:39:54', '2025-11-26 16:39:54', 1, NULL);
INSERT INTO `usuarios` VALUES (28, NULL, 'Angel Rafael Valera Campos', 'V-18405531', '2000-01-01', 'M', 'angelvalera80@gmail.com', NULL, '$2y$12$Ci6TU8d.8conwri6trSFHeuU4Qc/McyzsQ2clwTA32fY.Smsbqe86', NULL, '2025-11-26 20:09:09', '2025-11-26 20:09:09', 1, NULL);
INSERT INTO `usuarios` VALUES (29, NULL, 'Jose Alejandro Cortez Medina', 'V-22613465', '1995-08-04', 'M', 'josealejandrocortezmedina@gmail.com', NULL, '$2y$12$VK9okD/hkLCvBwChht0LCuf4/RHU9A8xopfiCa0Ql4V6Oo4nYWH1u', NULL, '2025-11-26 21:27:00', '2025-11-26 21:27:00', 1, NULL);
INSERT INTO `usuarios` VALUES (30, NULL, 'Maria Emilia Alfonzo Aparicio', 'V-32649049', '2008-06-06', 'F', 'maria@gmail.com', NULL, '$2y$12$OBjOUboHbPLEBI9.YIDOA.45YQxrjn5Vkzi3GY0pOg5fNeeU/U1z.', NULL, '2025-11-26 22:40:44', '2025-11-26 22:40:44', 1, NULL);
INSERT INTO `usuarios` VALUES (31, NULL, 'Hector Rafael Corro Solorzano', 'V-16075887', '1984-07-12', 'M', 'hectorcorrosolorzano@gmail.com', NULL, '$2y$12$K582fWllG72001lkSIPmgOZ69G8/Qux1/1vBMjoh.cU6AtN33o/.u', NULL, '2025-11-27 16:56:44', '2025-11-27 16:56:44', 1, NULL);
INSERT INTO `usuarios` VALUES (32, NULL, 'Yessis Patricia Moyetones Camacho', 'V-19476004', '1999-01-01', 'F', 'yessis_1121@hotmail.com', NULL, '$2y$12$TAutjHd2VVidsCgXNQONm.OlEpa1QP5ABqGRhyeO5kJ.I575NXtrK', NULL, '2025-11-27 18:42:50', '2025-11-27 18:57:59', 1, NULL);
INSERT INTO `usuarios` VALUES (33, NULL, 'Yajaira Coromoto Urbina', 'V-3853680', '1999-01-01', 'F', 'yajaira.c.urbina@gmail.com', NULL, '$2y$12$miAEEkDNcM/IJ2T5cm6PduBd0wyKtLjrMpIYLOnRhBgEa87yvdoL2', NULL, '2025-11-27 18:49:18', '2025-11-27 18:49:18', 1, NULL);
INSERT INTO `usuarios` VALUES (34, NULL, 'Eric Alejandro Graterol Gil', 'V-20524801', '1998-01-01', 'M', 'alemedic27@gmail.com', NULL, '$2y$12$TjbsXFJcVRbDa2Ek/H/D6uiHUAr/Zc/QHsK/N/hInxMVAjtHhp9zi', NULL, '2025-11-27 18:53:37', '2025-11-27 18:56:31', 1, NULL);
INSERT INTO `usuarios` VALUES (35, NULL, 'Nazareth Andrimar Hernandez Aguirre', 'V-24235111', '1999-01-01', 'F', 'nazarethahernandeza@gmail.com', NULL, '$2y$12$kfbkq185rf5R7iGgN2MwnusrcHS3BntxgBA8vcx1QsCEov60ZIdzu', NULL, '2025-11-27 19:02:35', '2025-11-27 19:02:35', 1, NULL);
INSERT INTO `usuarios` VALUES (36, 2, 'Luis Paul Mirabal', 'V-25549837', '1996-05-08', 'M', 'luispaulmar@gmail.com', NULL, '$2y$12$/qwZyEuMDj4lWjKcxU5dNumlxdp1matcVrUEHtLgpK1VAuTiU9m5K', NULL, '2025-11-27 21:37:09', '2025-11-27 21:37:09', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
