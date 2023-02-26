// SPDX-License-Identifier: GPL-2.0

/*
 * MEC170X eSPI Controller Driver
 */
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_platform.h>
#include <linux/platform_device.h>
#include <linux/spi/spi.h>

static int mec1705_espi_probe(struct platform_device *ofdev)
{
    return 0;
}

static int mec1705_espi_remove(struct platform_device *device)
{
    return 0;
}

static const struct of_device_id of_mec1705_espi_match[] = {
	{ .compatible = "microchip,mec1705-espi" },
	{}
};

MODULE_DEVICE_TABLE(of, of_mec1705_espi_match);

/*
 * Make compatible with mec1705 ACPI SSDT via the
 * Compatible ID (_CID) name object
 */
static const struct acpi_device_id mec1705_acpi_match[] = {
    { "MEC1705", 0 },
	{ "mec1705", 0 },
	{ }
};

MODULE_DEVICE_TABLE(acpi, mec1705_acpi_match);

static const struct platform_device_id mec1705_platform_devid[] = {
	{ "mec1705", 0 },
	{ }
};

static struct platform_driver mec1705_espi_driver = {
	.driver = {
		.name = "mec1705_espi",
		.of_match_table = of_mec1705_espi_match,
		.acpi_match_table = mec1705_acpi_match,
	},
    .id_table   = mec1705_platform_devid,
	.probe		= mec1705_espi_probe,
	.remove		= mec1705_espi_remove,
};

module_platform_driver(mec1705_espi_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Underview");
MODULE_DESCRIPTION("Microchip MEC1705 eSPI Controller Driver");
