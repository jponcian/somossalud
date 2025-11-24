DROP TABLE IF EXISTS `resultados_laboratorio`;

CREATE TABLE `resultados_laboratorio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `paciente_id` bigint(20) unsigned NOT NULL,
  `clinica_id` bigint(20) unsigned NOT NULL,
  `tipo_examen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_examen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_muestra` date NOT NULL,
  `fecha_resultado` date NOT NULL,
  `resultados_json` json DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_verificacion` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registrado_por` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resultados_laboratorio_codigo_verificacion_unique` (`codigo_verificacion`),
  KEY `resultados_laboratorio_codigo_verificacion_index` (`codigo_verificacion`),
  KEY `resultados_laboratorio_paciente_id_foreign` (`paciente_id`),
  KEY `resultados_laboratorio_clinica_id_foreign` (`clinica_id`),
  KEY `resultados_laboratorio_registrado_por_foreign` (`registrado_por`),
  CONSTRAINT `resultados_laboratorio_clinica_id_foreign` FOREIGN KEY (`clinica_id`) REFERENCES `clinicas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `resultados_laboratorio_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `resultados_laboratorio_registrado_por_foreign` FOREIGN KEY (`registrado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
